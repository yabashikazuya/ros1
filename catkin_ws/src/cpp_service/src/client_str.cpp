#include<ros/ros.h>
#include<cpp_service/string.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "str_client");
    ros::NodeHandle nh;
    ros::ServiceClient srv_client = nh.serviceClient<cpp_service::string>("string");
    cpp_service::string::Request req;
    cpp_service::string::Response res;
    req.x = "Hello!";
    bool result = srv_client.call(req, res);
    if(result) ROS_INFO_STREAM(res.y);     // レスポンス受信の表示
    else ROS_INFO_STREAM("Error!");
}