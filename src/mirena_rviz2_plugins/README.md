# RVIZ2 plugins for mirena common messages

## How to add new plugins

- Add a source `<message>.cpp` file to the `src/display` folder

- Update the `rviz_common_plugings`. The path field should be `<message>`

- *DO NOT TOUCH THE CMAKE FILE*. It is already automated to export every plugin in the display directory

- Source ros as usual