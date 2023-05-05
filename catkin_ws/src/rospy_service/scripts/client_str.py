#! /usr/bin/env python3
import rospy

from rospy_service.srv import string

# nodeの初期化
rospy.init_node('client')
# serviceが公開されるまで待つ
rospy.wait_for_service('service')

word = rospy.ServiceProxy('service', string)
# serviceの実行

print("Response: ", word('Hello!').y)