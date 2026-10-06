# As defined in the TER.dbc
uint8 MISSION_STATUS_INACTIVE = 0 # None Mission is Selected. All Nodes are unconfigured
uint8 MISSION_STATUS_CONFIGURING = 1 # Mission is selected. Nodes are initializing and nothing can be assumed of their state
uint8 MISSION_STATUS_READY = 2 # Mission is selected. Nodes are configured and inactive
uint8 MISSION_STATUS_RUNNING = 3 # Mission is selected. Nodes are active and control is being forwarded
uint8 MISSION_STATUS_FINISHED = 4 # Mission is finished. Dead end. Nodes are in unknown state. No control is being forwarded
uint8 MISSION_STATUS_FAILED = 5 # Kaputt kaputt :(


# Vars
uint8 status

# Data requiered for RES
uint32 cones_count_actual
uint32 cones_count_total
uint32 lap_counter