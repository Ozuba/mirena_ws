# AS state
uint8 AS_STATUS_OFF = 1 # System is inactive
uint8 AS_STATUS_READY = 2 # System has passed checks and mission is selected
uint8 AS_STATUS_DRIVING = 3 # System has solicitated driving
uint8 AS_STATUS_EMERGENCY = 4 # System is unable to drive
uint8 AS_STATUS_FINISHED = 5 # System mission has finished

# Mission Types
uint8 AS_MISSION_NONE = 0
uint8 AS_MISSION_ACCELERATION = 1
uint8 AS_MISSION_SKIDPAD = 2
uint8 AS_MISSION_TRACKDRIVE = 3
uint8 AS_MISSION_BRAKE_TEST = 4
uint8 AS_MISSION_INSPECTION = 5
uint8 AS_MISSION_AUTOCROSS = 6

# Variables
uint8 status
uint8 mission
