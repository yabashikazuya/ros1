#! /usr/bin/env python3

import rospy

from rospy_service.srv import string 

def callback(req):
    print("Request: ", req.x)
    return "world!!"

rospy.init_node('server')
# service名, service型, 実行される関数
service = rospy.Service('service', string, callback)

rospy.spin()