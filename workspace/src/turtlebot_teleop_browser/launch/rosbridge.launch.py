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
                            '/cmd_vel': {
                                'durability': 'transient_local'
                            }
                        }
                    }
                }
            ]
        ),
        # Launch web_video_server
        Node(
            package='web_video_server',
            executable='web_video_server',
            name='web_video_server',
            output='screen',
            parameters=[
                {'topic': '/oakd/rgb/preview/image_raw'}  # Specify the topic here
            ]
        )
    ])
