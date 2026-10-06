class_name TrackGenerator
extends RefCounted

## Random Trackdrive layouts that obey the Formula Student rules.
##
## The shape comes from Perlin noise, which is what gives chicanes, multiple
## turns and decreasing radius turns for free (D 8.1.1, "Miscellaneous"). The
## noise is only a proposal though: raw noise loops have corners no Formula
## Student car can physically turn, so each one is opened out, sized, and then
## measured against the rules. A layout that still breaks one is thrown away and
## another is drawn.
##
##   D 1.1.10  minimum turning diameter 9 m   -> MIN_TURN_RADIUS
##   D 8.1.1   straights no longer than 80 m  -> MAX_STRAIGHT_LENGTH
##   D 8.1.1   minimum track width 3 m        -> Track.track_width
##   D 8.1.2   lap length 200 m to 500 m      -> MIN/MAX_LAP_LENGTH
##
## Two things make this work. The first is that scale moves lap length and corner
## radius together, so the rules can be satisfied by choosing one number. The
## second is that everything is measured on the *baked* curve rather than on the
## points defining it: the gates are placed by sampling the baked curve, so that
## is the track, and a corner that passes on the control polygon can still be too
## tight once the curve is drawn through it.

# --- The rules -----------------------------------------------------------
const MIN_TURN_RADIUS := 4.5        ## D 1.1.10: 9 m diameter.
const MAX_STRAIGHT_LENGTH := 80.0   ## D 8.1.1.
const MIN_LAP_LENGTH := 200.0       ## D 8.1.2.
const MAX_LAP_LENGTH := 500.0       ## D 8.1.2.

# --- How they are applied ------------------------------------------------
## Build inside the turning limit. The rule is what the car can just about do;
## demanding exactly that leaves nothing for the racing line, or for a car that
## is already understeering.
const TURN_RADIUS_MARGIN := 1.25
## Arc length between samples, for measuring and for the curve's own points.
const SAMPLE_SPACING := 2.0
## A corner gentler than this counts as a straight for D 8.1.1.
const STRAIGHT_RADIUS := 75.0
## How near the loop may come to another part of itself. Two stretches of track
## closer than this share cones, and nothing downstream recovers from that.
const MIN_SELF_CLEARANCE := 8.0
## Corner opening. Without it nothing usable survives: noise corners are tight
## enough that scaling them out to a legal radius takes the lap past 500 m.
const RELAX_ROUNDS := 400
const RELAX_STRENGTH := 0.25
const MAX_ATTEMPTS := 40

# --- The noise -----------------------------------------------------------
const MAP_SIZE := Vector2i(512, 512)
const NOISE_THRESHOLD := 0.05
const NOISE_FREQUENCY := 0.005
const MIN_POLY_SIZE := 40
const SMOOTHING := 4
## Size the raw loop is laid out at, so corner opening works in metres. The rules
## decide the final size; this only has to be the right order of magnitude.
const LAYOUT_SCALE := 100.0

## What the last generate() produced: lap length, tightest corner, longest
## straight, self clearance, attempts, and whether it fell back.
var last_stats := {}


## A closed Trackdrive layout that obeys every rule above.
func generate() -> Curve3D:
	for attempt in MAX_ATTEMPTS:
		var raw := _noise_loop()
		if raw.is_empty():
			continue

		var points := _resample(_chaikin_smooth(raw, SMOOTHING))
		if points.size() < 8:
			continue

		var extent := _bounds(points).size
		points = _scaled(points, LAYOUT_SCALE / maxf(maxf(extent.x, extent.y), 0.001))
		points = _fit_to_rules(_relax_curvature(points))
		if points.is_empty():
			continue

		var curve := _build_curve(points)
		var stats := _measure(_bake(curve))
		if _obeys_rules(stats):
			stats["attempts"] = attempt + 1
			last_stats = stats
			return curve

	# Never hand back a track the car cannot drive. A circle is dull, but it is
	# legal by construction, so a failed generation degrades into a worse track
	# rather than into a broken run.
	push_warning("TrackGenerator: nothing legal in %d attempts, using the fallback circle" % MAX_ATTEMPTS)
	var fallback := _build_curve(_circle())
	last_stats = _measure(_bake(fallback))
	last_stats["attempts"] = MAX_ATTEMPTS
	last_stats["fallback"] = true
	return fallback


# --- Generation ----------------------------------------------------------

## The noise blob whose outline becomes the centreline.
##
## A threshold that clears nothing leaves no polygons at all; indexing that is
## how this used to crash rather than draw again.
func _noise_loop() -> PackedVector2Array:
	var noise := FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = NOISE_FREQUENCY
	noise.fractal_type = FastNoiseLite.FRACTAL_NONE

	var bitmap := BitMap.new()
	bitmap.create(MAP_SIZE)
	var centre := Vector2(MAP_SIZE) / 2.0
	var max_dist := centre.length() * 0.8

	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var falloff := clampf(1.0 - (Vector2(x, y).distance_to(centre) / max_dist), 0.0, 1.0)
			if noise.get_noise_2d(x, y) * falloff > NOISE_THRESHOLD:
				bitmap.set_bit(x, y, true)

	var polys: Array = bitmap.opaque_to_polygons(Rect2i(Vector2i.ZERO, MAP_SIZE)) \
		.filter(func(p): return p.size() > MIN_POLY_SIZE)
	if polys.is_empty():
		return PackedVector2Array()

	# The largest is the main loop; the rest are islands the noise left behind.
	polys.sort_custom(func(a, b): return a.size() > b.size())
	return polys[0]


## Opens out every corner tighter than the car can turn.
##
## Each pass slides a too-tight point towards the midpoint of its neighbours,
## the smallest local change that increases the radius there. Corners that are
## already legal are left alone, so hairpins stay hairpins instead of being
## smoothed into a circle.
func _relax_curvature(points: PackedVector2Array) -> PackedVector2Array:
	var target := MIN_TURN_RADIUS * TURN_RADIUS_MARGIN
	var current := points

	for round_index in RELAX_ROUNDS:
		var next := current.duplicate()
		var count := current.size()
		var violations := 0

		for i in count:
			var prev := current[(i - 1 + count) % count]
			var following := current[(i + 1) % count]
			if _circumradius(prev, current[i], following) >= target:
				continue
			violations += 1
			next[i] = current[i].lerp((prev + following) * 0.5, RELAX_STRENGTH)

		current = next
		if violations == 0:
			break

	return current


## Sizes the loop to satisfy the turning and lap length rules at once, or gives
## up on this shape.
##
## Scale is the whole lever: a loop twice the size has twice the lap length and
## twice the corner radius. So the smallest legal size is whichever constraint
## binds harder, and if that overshoots 500 m then this shape cannot be a
## Trackdrive layout and another one is worth more than more smoothing.
##
## Smallest rather than largest on purpose -- it keeps laps near 200 m, and a
## shorter lap has shorter straights, which is the remaining rule.
func _fit_to_rules(points: PackedVector2Array) -> PackedVector2Array:
	var length := _perimeter(points)
	var radius := _min_turn_radius(points)
	if length <= 0.0 or radius <= 0.0:
		return PackedVector2Array()

	var scale := maxf((MIN_TURN_RADIUS * TURN_RADIUS_MARGIN) / radius, MIN_LAP_LENGTH / length)
	if length * scale > MAX_LAP_LENGTH:
		return PackedVector2Array()

	# Resample after scaling: the samples were spaced for the old size, and every
	# measurement counts them.
	return _resample(_scaled(points, scale))


## The dullest legal track there is, for when the noise will not produce one.
func _circle() -> PackedVector2Array:
	var radius := MIN_LAP_LENGTH / TAU
	var points := PackedVector2Array()
	for i in int(MIN_LAP_LENGTH / SAMPLE_SPACING):
		var angle := TAU * i / int(MIN_LAP_LENGTH / SAMPLE_SPACING)
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	return points


# --- Measurement ---------------------------------------------------------

## Uniform samples of the curve the gates will actually be placed on.
func _bake(curve: Curve3D) -> PackedVector2Array:
	var points := PackedVector2Array()
	var distance := 0.0
	while distance < curve.get_baked_length():
		var p := curve.sample_baked(distance, true)
		points.append(Vector2(p.x, p.z))
		distance += SAMPLE_SPACING
	return points


func _measure(points: PackedVector2Array) -> Dictionary:
	return {
		"lap_length": _perimeter(points),
		"min_turn_radius": _min_turn_radius(points),
		"longest_straight": _longest_straight(points),
		"self_clearance": _min_self_clearance(points),
		"fallback": false,
	}


func _obeys_rules(stats: Dictionary) -> bool:
	return (
		stats["lap_length"] >= MIN_LAP_LENGTH
		and stats["lap_length"] <= MAX_LAP_LENGTH
		and stats["min_turn_radius"] >= MIN_TURN_RADIUS
		and stats["longest_straight"] <= MAX_STRAIGHT_LENGTH
		and stats["self_clearance"] >= MIN_SELF_CLEARANCE)


func _min_turn_radius(points: PackedVector2Array) -> float:
	var count := points.size()
	if count < 3:
		return 0.0
	var smallest := INF
	for i in count:
		smallest = minf(
			smallest,
			_circumradius(points[(i - 1 + count) % count], points[i], points[(i + 1) % count]))
	return smallest


## The longest run of samples gentle enough to count as straight, in metres.
## Walked twice around so a straight lying over the seam is counted whole.
func _longest_straight(points: PackedVector2Array) -> float:
	var count := points.size()
	if count < 3:
		return 0.0

	var longest := 0
	var run := 0
	for i in count * 2:
		var j := i % count
		var radius := _circumradius(points[(j - 1 + count) % count], points[j], points[(j + 1) % count])
		if radius >= STRAIGHT_RADIUS:
			run += 1
			longest = maxi(longest, run)
		else:
			run = 0
	return float(mini(longest, count)) * SAMPLE_SPACING


## How near the loop comes to another part of itself, ignoring samples that are
## close only because they are consecutive.
func _min_self_clearance(points: PackedVector2Array) -> float:
	var count := points.size()
	var skip := int(ceil(MIN_SELF_CLEARANCE * 2.0 / SAMPLE_SPACING)) + 1
	if count < skip * 2 + 2:
		return INF

	var closest := INF
	for i in count:
		for j in range(i + skip, count):
			# Distance the other way round the loop, so the seam is not a gap.
			if count - (j - i) < skip:
				continue
			closest = minf(closest, points[i].distance_to(points[j]))
	return closest


## Radius of the circle through three points; INF when they are collinear.
func _circumradius(a: Vector2, b: Vector2, c: Vector2) -> float:
	var area2 := absf((b - a).cross(c - a))
	if area2 < 1e-9:
		return INF
	return (a.distance_to(b) * b.distance_to(c) * c.distance_to(a)) / (2.0 * area2)


# --- Geometry helpers ----------------------------------------------------

func _perimeter(points: PackedVector2Array) -> float:
	var total := 0.0
	for i in points.size():
		total += points[i].distance_to(points[(i + 1) % points.size()])
	return total


func _bounds(points: PackedVector2Array) -> Rect2:
	var box := Rect2(points[0], Vector2.ZERO)
	for p in points:
		box = box.expand(p)
	return box


func _scaled(points: PackedVector2Array, factor: float) -> PackedVector2Array:
	var centre := _bounds(points).get_center()
	var out := PackedVector2Array()
	for p in points:
		out.append(centre + (p - centre) * factor)
	return out


## Even arc-length spacing around a closed polyline. Every measurement counts
## samples rather than integrating, so they have to be evenly spaced for the
## counting to mean anything.
func _resample(points: PackedVector2Array) -> PackedVector2Array:
	var total := _perimeter(points)
	if total < SAMPLE_SPACING * 4.0:
		return PackedVector2Array()

	var out := PackedVector2Array()
	var walked := 0.0
	var target := 0.0
	var count := points.size()

	for i in count:
		var a := points[i]
		var b := points[(i + 1) % count]
		var segment := a.distance_to(b)
		while target < walked + segment and out.size() * SAMPLE_SPACING < total:
			out.append(a.lerp(b, (target - walked) / maxf(segment, 1e-9)))
			target += SAMPLE_SPACING
		walked += segment

	return out


func _chaikin_smooth(points: PackedVector2Array, iterations: int) -> PackedVector2Array:
	var output := points
	for i in iterations:
		var next := PackedVector2Array()
		for j in output.size():
			var p0 := output[j]
			var p1 := output[(j + 1) % output.size()]
			next.append(p0.lerp(p1, 0.25))
			next.append(p0.lerp(p1, 0.75))
		output = next
	return output


# --- Curve ---------------------------------------------------------------

func _build_curve(points: PackedVector2Array) -> Curve3D:
	var curve := Curve3D.new()
	curve.closed = true

	# Centred on the world origin, because that is where the ground plane is and
	# it is only 200 m across. Everything upstream works in the noise bitmap's own
	# coordinates, so without this the loop is laid out a few hundred metres out
	# and the cones drop through nothing. Every measurement above is a distance,
	# so moving the whole loop changes none of them.
	var centre := _bounds(points).get_center()
	for p in points:
		curve.add_point(Vector3(p.x - centre.x, 0, p.y - centre.y))

	# Tangents give the curve the "soft" look; the measurements above are taken
	# after this, on the baked result, so what they check is what gets driven.
	for i in curve.point_count:
		var curr := curve.get_point_position(i)
		var prev := curve.get_point_position(posmod(i - 1, curve.point_count))
		var next := curve.get_point_position(posmod(i + 1, curve.point_count))
		var dir := (next - prev).normalized()
		var dist := curr.distance_to(next) * 0.35
		curve.set_point_in(i, -dir * dist)
		curve.set_point_out(i, dir * dist)

	return curve
