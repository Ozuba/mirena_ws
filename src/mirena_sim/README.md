# MirenaSim 🏎️ 🤖

MirenaSim is a high-performance, ROS2-integrated simulator built with **Godot 4**. It is specifically designed for **Formula Student Driverless** teams to test and validate autonomous driving stacks in a realistic 3D environment.

Built on top of [rclgd](https://github.com/Ozuba/rclgd)a low-latency client library for communication between Godot's engine and the ROS2 ecosystem.

## Key Features

- **High-Fidelity Physics**: Vehicle dynamics using Godot's 3D physics engine.
- **Native ROS2 Integration**: Direct access to `rclgd` from GDScript for publishers, subscribers, and TF broadcasting.
- **GPU-Accelerated Sensors**:
  - **Lidar**: High-bandwidth PointCloud2 generation using GPU shaders.
  - **Camera**: RGB image publishing with full camera info (intrinsics/extrinsics).
  - **IMU**: Linear acceleration and angular velocity reporting.
- **Dynamic Track Generation**: Procedurally generate tracks using Perlin noise and Chaikin smoothing.
- **Format-Compatible**: Load tracks from standard JSON formats used in Formula Student competitions.
- **Formula Student Standards**: Includes simulated cones (Blue, Yellow, Orange) and EBS (Emergency Braking System) logic.


## Getting Started

### Prerequisites

- **Godot 4.3+** (Forward+ renderer support)
- **ROS2 Humble/Jazzy**
- **rclgd**: The ROS2-Godot bridge library.

### Building

MirenaSim is an rclgd package, you need to have rclgd installed to build it and launch it.

```bash
colcon build --packages-select mirena_sim
```

### Running

Launch the simulator as a ROS2 node:

```bash
ros2 run mirena_sim mirena_sim
```
### Editing
Use `ros2 run rclgd godot` to run the godot editor and edit your `src/` instance of mirena_sim.


## 📡 ROS2 API

### Published Topics

| Topic | Type | Freq | Description |
|-------|------|------|-------------|
| `/car/state` | `mirena_common/msg/Car` | 50Hz | Global pose and local velocities. |
| `/car/cloud` | `sensor_msgs/msg/PointCloud2` | 10Hz | GPU-generated Lidar points. |
| `/car/image_raw` | `sensor_msgs/msg/Image` | 15Hz | Camera feed (RGBA8). |
| `/car/camera_info` | `sensor_msgs/msg/CameraInfo` | 15Hz | Camera intrinsics. |
| `/track_manager/track` | `mirena_common/msg/Track` | 1Hz | Current track path/gates. |
| `/track_manager/full_map` | `mirena_common/msg/EntityList` | 1Hz | All cones in the environment. |
| `/tf` | `tf2_msgs/msg/TFMessage` | - | Static and dynamic transforms. |

### Subscribed Topics

| Topic | Type | Description |
|-------|------|-------------|
| `/car/control` | `mirena_common/msg/CarControl` | Drive commands (gas, steer). |

## 🎮 Controls

| Action | Keyboard | Joypad |
|--------|----------|--------|
| **Throttle** | `W` | `R2` |
| **Brake/Reverse**| `S` | `L2` |
| **Steer Left** | `A` | `LS Left` |
| **Steer Right** | `D` | `LS Right` |
| **EBS (Emergency)**| `Space`| - |
| **Switch Camera**| `V` | - |
| **Sim Menu** | `Esc` | - |

## 📐 Coordinate Systems

MirenaSim strictly follows **REP 103** for ROS2 interoperability.

- **Godot**: Y-Up, Right-Handed.
- **ROS2**: Z-Up, X-Forward, Y-Left.
- **Swizzling**: The simulator internal logic handles the conversion:
  - `ROS X = Godot +Z`
  - `ROS Y = Godot +X`
  - `ROS Z = Godot +Y`

## ⚙️ Configuration

### Parameters

- `track` (string): Path to a `.json` track file or set to `"random"` for procedural generation.
- `use_sim_time` (bool): Whether to sync with ROS2 clock (Default: `false`).


## Notice
All work done here is subject at the moment to API changes and breakages. Things may be broke and will be broken for some time. It is requiered as now for you to rewrite and bring your own ROS2 interfaces, I intend to standarize things and polish them as FS season ends, however feel free to suggest any improvements and suggestions you find intrasting in the Issues.

## License and Copyright

Copyright (C) 2026 Miguel Oroz Zubasti

This project is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

Assets are licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
See the [LICENSE](LICENSE) file for the full text.