## SOLUTION

This Document contain all the technical information regarding Test Application 

As you already provided a boilerplate app so I started from it. 

Features added
•	Loading Screen: To make good experience I am showing loading screen identical to splash screen. 
•	In case of success: This screen will hide and will show you photos’ list screen with photos data, photos will download async in background. I am not stopping user for that because it seems really bad to wait for downloading all photos. 
•	In case of error: In error, it will hide and you will see Empty Data set.

•	Photos List Screen (FeedViewController): This screen will show you list of downloaded photos from Flickr API. This is Root View Controller of app and initiates API calls from this screen. And presents loading screen. 
•	Internet Connection Check: Before initiate API calls I am checking internet. 
•	Empty Data Set: In any case if API not provide us data, I am showing Empty Data Set message.
•	Internet Connection check: This library I am using to check internet connection status in app. Also I am notify the user if connection status goes offline or online.
•	Notification: It display message on screen from top position of screen. 
•	Flickr API: I made some changes now instead of just URL its returning me other data as well. that’s how I am getting name of picture.
•	Photos View Model: As you guys demand MVVM so I use it in app. But I am not using Model because I think its adding unnecessary complexity in this simple app. Previously you guys just using URL from Flickr API now I am using name property as well so that is why I am directly using View Model. 
•	This View Model is responsible to transform row data to presentable form of data. e.g. URL to cacheable Image, display and hiding image loading, name display etc.
•	Photo View Pager: This class is responsible to display photos in full view. You can swipe photos to see next and previous. I am not downloading photos in this View controller because I already downloading all images via View Model in feed view controller. This approach helps me to enhance the experience. 


Note: I made my architecture according current demand and fare enough prediction of scalability. Sometimes we add too much complexity by over thinking.   



