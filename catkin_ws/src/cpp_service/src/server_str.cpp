#include<ros/ros.h>
#include<cpp_service/string.h>

// コールバック関数
bool CallBack(cpp_service::string::Request &req, cpp_service::string::Response &res)
{
    ROS_INFO_STREAM("request:" << " " << req.x);
    res.y = "World!";
    return true;
}

int main(int argc, char **argv)
{
    // ノードの初期化
    ros::init(argc, argv, "str_server");
    // ノードハンドルの作成
    ros::NodeHandle nh;
    // service名, 実行される関数
    ros::ServiceServer srv = nh.advertiseService("string", &CallBack);
    ROS_INFO_STREAM("Service ready!");
    // 無限ループ的な？
    ros::spin();
}