Development environment
=======================

The workspace is developed inside a **Docker container** that VS Code opens as a
**Dev Container**. The container image includes Ubuntu 24.04, ROS 2 Jazzy, ``rclgd`` with its
Godot build, the Vulkan userspace drivers, and a preconfigured zsh shell. The host only needs
Docker, VS Code and a working X11/XWayland display.

This guide covers **Ubuntu 22.04/24.04** and **Debian 12/13** hosts.

.. contents:: On this page
   :local:
   :depth: 2

How the pieces fit
------------------

.. mermaid::

   flowchart LR
     subgraph Host["Host (Ubuntu / Debian)"]
       VS[VS Code + Dev Containers]
       X[X server / XWayland]
       GPU[/dev/dri GPU/]
       SRC[(~/mirena_ws)]
     end
     subgraph C["Container: mirena_ws (ubuntu:24.04)"]
       ROS[ROS 2 Jazzy]
       GD[rclgd + Godot]
       WS[/home/mirena/mirena_ws/]
     end
     VS -- docker compose up --> C
     SRC -- bind mount --> WS
     X -- /tmp/.X11-unix --> GD
     GPU -- /dev, Vulkan ICDs --> GD

The relevant files are:

``.devcontainer/devcontainer.json``
   Tells VS Code to start the ``mirena_ws`` service from the compose file, to open
   ``/home/mirena/mirena_ws``, and to install the ROS, Python and C++ extensions inside the
   container. Its ``initializeCommand`` runs ``xhost +local:docker`` on the host before every start,
   so windows opened in the container (Godot, RViz) can reach your display.

``docker/docker-compose.yml``
   Runs the container with ``network_mode: host`` and ``ipc: host``, so DDS discovery and shared
   memory transport work with ROS nodes on the host. It is ``privileged``, mounts ``/dev`` and the
   host's Vulkan ICD files for GPU access, and bind-mounts the repository root into the container.

``docker/Dockerfile``
   Builds the image: creates the ``mirena`` user (UID/GID 1000, in the ``video`` and ``render``
   groups), adds the ROS 2 apt repository, and installs ``ros-jazzy-desktop``, ``ros-dev-tools``,
   ``ros-jazzy-rclgd`` and the Mesa Vulkan drivers. It also sets ``ROS_DOMAIN_ID=42`` and sources
   ``/opt/ros/jazzy`` and the workspace overlay from ``~/.zshrc``.

1. Install Docker Engine
------------------------

Install Docker from Docker's own apt repository. Distribution packages such as ``docker.io`` are
often too old for BuildKit features the Dockerfile uses (``RUN --mount=type=cache``).

Remove conflicting packages, if any:

.. code-block:: bash

   for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
     sudo apt-get remove -y $pkg
   done

Add the repository that matches your host:

**Ubuntu**

.. code-block:: bash

   sudo apt-get update
   sudo apt-get install -y ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
     https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
     | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

**Debian**

.. code-block:: bash

   sudo apt-get update
   sudo apt-get install -y ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
     https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
     | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

Then install the engine together with the Buildx and Compose plugins:

.. code-block:: bash

   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
     docker-buildx-plugin docker-compose-plugin

Let your user run Docker without ``sudo``. VS Code needs this to manage the container. Log out and
back in afterwards, or run ``newgrp docker`` in the current shell:

.. code-block:: bash

   sudo usermod -aG docker $USER

Check the installation:

.. code-block:: console

   $ docker run --rm hello-world
   $ docker compose version

.. tip::

   The devcontainer runs ``xhost`` on the host. If it is missing, install it with
   ``sudo apt-get install -y x11-xserver-utils``.

2. Check the GPU and the display
--------------------------------

The simulator renders with Godot's **Forward+** renderer on **Vulkan**, and the lidar and depth
camera run as Vulkan compute shaders. The container has to see a Vulkan-capable GPU.

**Intel and AMD GPUs** work out of the box: the container uses the Mesa drivers and gets the
device nodes through the ``/dev`` mount. Confirm the host exposes the render node:

.. code-block:: console

   $ ls /dev/dri
   card0  renderD128

The compose file adds the container user to groups ``44`` (``video``) and ``992``. Group ``992``
must match the GID of the host's ``render`` group, which varies between distributions. Check yours
and edit ``group_add`` in ``docker/docker-compose.yml`` if it differs:

.. code-block:: console

   $ getent group render
   render:x:992:

**NVIDIA GPUs** with the proprietary driver need the
`NVIDIA Container Toolkit <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html>`_
and a ``deploy.resources.reservations.devices`` entry (or ``runtime: nvidia``) in the compose
service. This is not configured in the repository yet.

**Display.** Programs in the container draw on the host's X server through
``/tmp/.X11-unix`` and ``$DISPLAY``. On a Wayland session (the default on Ubuntu and on Debian with
GNOME) this goes through XWayland, which is enabled by default. Make sure ``echo $DISPLAY`` prints
a value such as ``:0`` in the terminal you start VS Code from.

.. warning::

   ``xhost +local:docker`` lets every local container connect to your X server. That is fine on a
   personal development machine. On a shared machine, revoke it with ``xhost -local:docker`` when
   you are done.

3. Install VS Code and the Dev Containers extension
---------------------------------------------------

Install VS Code from Microsoft's apt repository:

.. code-block:: bash

   sudo apt-get install -y wget gpg apt-transport-https
   wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
   sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
   echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
     https://packages.microsoft.com/repos/code stable main" \
     | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y code

Install the **Dev Containers** extension (``ms-vscode-remote.remote-containers``) from the
Extensions view, or from a terminal:

.. code-block:: bash

   code --install-extension ms-vscode-remote.remote-containers

You don't need to install the ROS, Python or C++ extensions on the host. ``devcontainer.json``
installs them inside the container:

- ``Ranch-Hand-Robotics.rde-ros-2``: ROS 2 integration, configured for ``jazzy``
- ``ms-python.python``
- ``ms-vscode.cpptools-extension-pack``

4. Clone and open the workspace
-------------------------------

.. code-block:: bash

   git clone <repository-url> ~/mirena_ws
   code ~/mirena_ws

When VS Code detects ``.devcontainer/devcontainer.json``, it offers **Reopen in Container**. You
can also open the Command Palette (:kbd:`Ctrl+Shift+P`) and run
**Dev Containers: Reopen in Container**.

The first start builds the image, which takes several minutes because it downloads
``ros-jazzy-desktop``. Later starts reuse the image, and the apt cache mounts make rebuilds
quick. When it finishes, the VS Code window is attached to the container and its terminals open a
zsh shell as user ``mirena`` in ``/home/mirena/mirena_ws``.

.. note::

   The repository is bind-mounted, not copied. Edits made in the container show up on the host
   and vice versa, and files created in the container are owned by UID 1000. If your host user has
   a different UID, change ``USER_UID``/``USER_GID`` in the Dockerfile.

To rebuild the image after changing the Dockerfile, run
**Dev Containers: Rebuild Container**.

Without VS Code, the same container can be used from any terminal:

.. code-block:: bash

   cd ~/mirena_ws/docker
   xhost +local:docker
   docker compose up -d --build
   docker exec -it mirena_ws zsh

5. Build the workspace
----------------------

Inside the container:

.. code-block:: bash

   cd ~/mirena_ws
   colcon build --symlink-install
   source install/setup.zsh

New shells source ``install/setup.zsh`` automatically once it exists (see ``~/.zshrc``).

``mirena_sim`` is built by the ``rclgd`` colcon build type. It installs the Godot project under
``install/mirena_sim/share/mirena_sim`` together with a launcher. When ``rclgd`` loads the
project, it generates typed GDScript wrappers for every message package listed in
``src/mirena_sim/package.xml`` (for example ``RosSensorMsgsImu`` or ``RosMirenaCommonCar``) into
``addons/rclgd/gen``.

6. Run and edit the simulator
-----------------------------

Run the installed simulator as a ROS 2 executable:

.. code-block:: bash

   ros2 run mirena_sim mirena_sim --ros-args -p track:=random

``track`` takes ``random`` for a generated Trackdrive layout, or a path to a track ``.json`` file
(see :ref:`simulator/overview:Tracks`).

To edit the simulator, open your source copy in the Godot editor that ships with ``rclgd``:

.. code-block:: bash

   ros2 run rclgd godot --editor --path src/mirena_sim

The main scene is ``res://Scenes/Sim/Sim.tscn``, and the car is
``res://Scenes/Vehicle/mirena_car.tscn`` (see :doc:`../simulator/overview` and
:doc:`../simulator/vehicle`).

From the editor, **Run Project** (:kbd:`F5`) starts the simulator straight from ``src/``, with no
rebuild. Run ``colcon build`` again before using ``ros2 run mirena_sim mirena_sim``, so the
installed copy picks up your changes.

To check that everything works, open a second terminal and list the topics:

.. code-block:: console

   $ ros2 topic list
   /as_status
   /camera/camera_info
   /camera/image_raw
   /control
   /debug/state/car
   /lidar/lidar
   /ros_imu/data
   /sensors/wheel_speeds
   /tf
   /tf_static
   /track_manager/full_map
   /track_manager/track
   ...

Then start RViz with the bundled configuration:

.. code-block:: bash

   rviz2 -d src/mirena_sim/mirena_sim.rviz

.. important::

   Sensor topics use **best-effort** QoS (see :ref:`sensors/index:Quality of service`). In RViz,
   set the display's *Reliability Policy* to *Best Effort*. With ``ros2 topic echo``, pass
   ``--qos-reliability best_effort``. Otherwise you will see no data.

Troubleshooting
---------------

``Authorization required, but no authorization protocol specified`` / ``cannot open display``
   ``xhost`` did not run, or ran for the wrong display. Run ``xhost +local:docker`` on the host,
   then **Rebuild Container** so ``DISPLAY`` is passed in again.

Godot falls back to ``llvmpipe`` or reports no Vulkan device
   The container cannot reach the GPU. Check ``ls -l /dev/dri`` inside the container, and check
   that the ``render`` GID in ``group_add`` matches the host. ``vulkaninfo --summary`` should list
   your GPU and not only ``llvmpipe``.

No topics visible from the host
   The container sets ``ROS_DOMAIN_ID=42``. Export the same value on the host, or unset it in both.

``Package 'mirena_sim' not found``
   The workspace overlay is not sourced. Run ``source install/setup.zsh`` after building.
