Sensors
=======

The sensors are provided by the ``rclgd-sensors`` addon (``src/mirena_sim/addons/rclgd-sensors``).
Each sensor is a ``Node3D`` that you attach to the car (see
:ref:`simulator/vehicle:Adding, moving and removing sensors`). It publishes standard
``sensor_msgs`` types, so RViz, image_proc, PCL and your own nodes read them exactly as they would read data from real drivers.

.. list-table::
   :header-rows: 1
   :widths: 18 30 22 30

   * - Sensor
     - Message
     - Implementation
     - Model
   * - :doc:`lidar`
     - ``PointCloud2`` (organized)
     - GPU: cube map + compute
     - Ray directions from a configurable FOV grid, range noise that depends on distance and
       intensity, Lambertian intensity
   * - :doc:`camera`
     - ``Image`` + ``CameraInfo``, optional depth
     - GPU: viewport readback
     - Ideal pinhole, optional linear depth
   * - :doc:`imu`
     - ``Imu``
     - CPU, physics tick
     - Proper acceleration at the mount point, white noise, random-walk bias, low-pass filter
   * - :doc:`gps`
     - ``NavSatFix``
     - CPU, ROS timer
     - Local tangent plane on WGS-84, Gauss–Markov position error

Common behaviour: ``RosSensor``
-------------------------------

Every sensor extends the abstract ``RosSensor`` class (``ros_sensor.gd``), which does the
following:

1. **Creates a ROS node** named after the Godot node in snake_case (``Lidar`` → ``lidar``,
   ``RosImu`` → ``ros_imu``), inside ``ros_namespace``. Topics are private to that node
   (``~/data`` → ``/ros_imu/data``).
2. **Publishes the mount transform once** on ``/tf_static``, from ``parent_frame_id`` to
   ``frame_id``, using the node's transform relative to its Godot parent. Sensors are assumed to be
   rigidly mounted.
3. **Samples at a fixed rate.** ``_start_sampling(rate)`` creates a ``RosTimer``. The first sample
   is delayed by a random fraction of the period, so sensors with the same rate don't all render
   and publish in the same frame.
4. **Publishes off the main thread.** GPU sensors push their read-back data into a
   ``PublishQueue``: one worker thread per stream, which publishes captures strictly in capture
   order and drops the oldest one if more than 3 are waiting.

Common parameters
~~~~~~~~~~~~~~~~~

These appear in the **ROS 2 Settings** group of every sensor:

.. list-table::
   :header-rows: 1
   :widths: 22 18 60

   * - Parameter
     - Default
     - Description
   * - ``ros_namespace``
     - ``""``
     - Namespace for the sensor's node, topics and ``~`` frames.
   * - ``frame_id``
     - ``""``
     - TF frame of the sensor. Empty uses ``~<node_name>``. A leading ``~`` puts the frame under
       ``ros_namespace`` (``~lidar`` → ``<namespace>/lidar``).
   * - ``parent_frame_id``
     - ``~base_link``
     - Frame that the mount transform is published in. On the Mirena car this is ``car/cog``.
   * - ``publish_rate``
     - sensor-specific
     - Samples per second.

Quality of service
~~~~~~~~~~~~~~~~~~

All sensor publishers use the equivalent of ``rclcpp::SensorDataQoS``:

- reliability **best effort**
- history **keep last 5**
- durability **volatile**

Stale sensor data isn't worth retransmitting, so lost samples are simply dropped. **A reliable
subscriber doesn't match a best-effort publisher**, and receives nothing. Subscribe with
``rclpy.qos.qos_profile_sensor_data`` or ``rclcpp::SensorDataQoS()``, and set RViz displays to
*Best Effort*.

Timestamps
~~~~~~~~~~

GPU sensors (lidar, camera) stamp each sample **when it is requested**, which is the moment the
scene is rendered. The data reaches ROS a few frames later. Each message therefore describes the
world at its header stamp, not at its arrival time. Use ``header.stamp``, for example with
``tf2`` ``lookupTransform(..., stamp)``, whenever you relate sensor data to the car's pose.

Rendering and layers
~~~~~~~~~~~~~~~~~~~~

GPU sensors render the same scene as the window, through their own cameras. Their
``cull_mask`` (3D render layers) controls what they see. Everything with a visual mesh is visible
by default, including the car's own body. To hide meshes from a sensor, move them to a render
layer that is excluded from its ``cull_mask``.
