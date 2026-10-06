cmake_minimum_required(VERSION 3.8)
project(mirena_rviz2_plugins)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(pluginlib REQUIRED) 
find_package(rviz_common REQUIRED)
find_package(rviz_rendering REQUIRED)
find_package(mirena_common REQUIRED)
find_package(Qt5 REQUIRED COMPONENTS Widgets)

# AUTOMOC processes Q_OBJECT macros
set(CMAKE_AUTOMOC ON)

# 1. Collect sources AND headers (AUTOMOC needs to scan headers for Q_OBJECT!)
file(GLOB DISPLAY_SOURCES "src/displays/*.cpp")
file(GLOB DISPLAY_HEADERS "src/displays/*.hpp" "src/displays/*.h")

# 2. Create the shared library containing both sources and headers
add_library(mirena_rviz2_plugins SHARED
  ${DISPLAY_SOURCES}
  ${DISPLAY_HEADERS}
)

# 3. CRITICAL: Tell CMake and AUTOMOC where your header files are located!
target_include_directories(mirena_rviz2_plugins PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

# 4. Add dependencies
ament_target_dependencies(mirena_rviz2_plugins
  pluginlib
  rviz_common 
  rviz_rendering 
  mirena_common
)

target_link_libraries(mirena_rviz2_plugins 
  Qt5::Widgets
)

# 5. Install the library and headers
install(TARGETS mirena_rviz2_plugins
  EXPORT export_mirena_rviz2_plugins
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

# Install Icons
install(DIRECTORY icons/
  DESTINATION share/${PROJECT_NAME}/icons
)

# 6. Export the plugin description XML
pluginlib_export_plugin_description_file(rviz_common rviz_common_plugins.xml)

# 7. Export targets and finish package
ament_export_targets(export_mirena_rviz2_plugins)
ament_package()