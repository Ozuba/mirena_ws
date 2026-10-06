# TIMESTAMP of the message
std_msgs/Header header 

# Actual control
float64 gas         # Unitless [-1,1] where -1 is full braking and 1 full gas
float64 steer_angle # In radians. Counter-Clockwise