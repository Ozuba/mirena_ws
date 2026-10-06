cmake_minimum_required(VERSION 3.8)
project(mirena_common)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(builtin_interfaces REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# ================== Message/Service Generation ==================
# Glob all .msg files in ./msg directory
file(GLOB COMMON_MSG
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "msg/*.msg"
)

# Force CMake to re-run when .msg files change
set(CMAKE_CONFIGURE_DEPENDS ${CMAKE_CONFIGURE_DEPENDS} ${COMMON_MSG})

rosidl_generate_interfaces(${PROJECT_NAME}
  ${COMMON_MSG}
  DEPENDENCIES geometry_msgs builtin_interfaces
)

# ================== Finalize ==================
ament_package()