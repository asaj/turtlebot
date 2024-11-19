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
        Node(
            package='image_transport',
            executable='republish',
            name='image_transport',
            arguments=['compressed'],
            remappings=[
                ('in/compressed', '/oakd/rgb/preview/image_raw/compressed'),
                ('out', '/oakd/rgb/preview/image_raw/decompressed')]
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
