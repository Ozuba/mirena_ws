# TIMESTAMP of the message
std_msgs/Header header 

# Car State (Position and Orientation measured on headers frame, usually odom)
float64 x
float64 y
float64 psi

# Frame of measurement of the velocities
string child_frame_id

# Car State (Linear and Angular Velocity)
float64 u    # Linear velocity in x direction (often vx)
float64 v    # Linear velocity in y direction (often vy)
float64 omega # Angular velocity around z axis (often wz)

# ----------------------------------------------------
# Covariance Matrix (Uncertainty)
# ----------------------------------------------------
# Row-major 6x6 matrix for the covariance of the 
# state vector: [x, y, theta, u, v, omega]
#
# The ordering MUST be consistent with the state fields above.
# Index 0: x
# Index 1: y
# Index 2: psi
# Index 3: u
# Index 4: v
# Index 5: omega
float64[36] covariance