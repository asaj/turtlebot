ros2 param set /oakd rgb.i_fps 5.0
ros2 param set /oakd rgb.i_low_bandwidth true
ros2 service call /oakd/stop_camera std_srvs/srv/Trigger "{}"
ros2 service call /oakd/start_camera std_srvs/srv/Trigger "{}"
