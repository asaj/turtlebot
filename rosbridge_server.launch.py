from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='rosbridge_server',
            executable='rosbridge_websocket',
            name='rosbridge_websocket',
            parameters=[
                {'use_sim_time': False},
                {
                    'qos_overrides': {
                        'publisher': {
                            '/locobot/commands/joy_raw': {
                                'durability': 'transient_local'
                            }
                        }
                    }
                }
            ]
        ),
    ])
