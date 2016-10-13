# SinaMicroBlog-iWatch

This is a [Sina Microblog](https://en.wikipedia.org/wiki/Sina_Weibo) App for Apple Watch and is motivated by [CoderMJLee](https://github.com/CoderMJLee)'s OAuth introduction.

Demo presentation: [YouTube](https://youtu.be/HjWLoYmpzhg)(Chinese).

 ![image](./img/new_feature_0.png)
 
 ![image](./img/new_feature_1.png)

## Motivation
Sina Microblog is one of the most popular social network in China. However, there is still no user-friendly app available for App Watch. Thus, I design and implement the first App for Apple Watch which has the following new features:

1. It's an app designed for Apple Watch that allows users to access Sina microblog via Apple Watch; 
2. It's the **FIRST** Apple Watch app that can refresh and load more blogs;         
3. It's the **FIRST** Apple Watch app that can display shared blogs;
4. It allows users to read more detailed information about a blog;
5. It allows users to 'like' or 'share' blogs. 


## Brief Technical Introduction
This app is developed based on [network interface](http://open.weibo.com) provided by Sina. Since there's no keyboard in Apple Watch, users can just log in by their iPhone. Then, connection is built between iPhone and Apple Watch by [WatchConnectivity](https://developer.apple.com/library/watchos/documentation/WatchConnectivity/Reference/WatchConnectivity_framework/) and data can be transferred between the two devices. 

## To Readers

There are still many places can be improved. For example, log out function can be added. Also, sometimes app may crash because of the usage of multi-thread technique in downloading pictures(since there's no library for Apple Watch to download pictures Asynchronously). Therefore, I welcome every reader to fork this project and help me to make this project be a great product!
