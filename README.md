# Walkie-Talkie

Video Calls Application using WebRTC and Firebase

Demo that uses WebRTC for video calls, based on Firebase signaling. 

<p align="center">
 <img src="https://user-images.githubusercontent.com/7135226/80953801-6a354980-8e26-11ea-84bf-ace79559d523.png" width="25%">
 <img src="https://user-images.githubusercontent.com/7135226/80954595-e2503f00-8e27-11ea-9d54-2c6700ab30cb.png" width="50%">
 </p>
 
 
**Technologies used:**

 - Language: Swift 5
 - Main Architectural pattern: MVVM + Router 
 - Dependency manager: CocoaPods 
 - Signaling and WebRTC: GoogleWebRTC, Firebase/Firestore
 - UI: Xib, Autolayout, UIStackView
 - Reactive Programming: ReactiveKit+Bond
 - Object JSON Mapping: Codable


Functionality description: 
- Create room by entering ID and pressing "create"
- Provide you ID to callee and make him enter ID and press "join"
- Enjoy video call 
- P.S. Currently it is mocked by simple cat.mp4 video, because of simulator restrictions. So, change the way you capturing video from local file to camera. 

You can use WebRTCClient and SignalingClient classes to make your own video call project, just create your own Firebase project and put GoogleService-Info.plist file into it.
Don't forget to call FirebaseApp.configure() in AppDelegate


## Contacts

Oleksandr Zaporozhchenko
[[github]](https://github.com/Maxatma)  [[gmail]](mailto:maxatma.ids@gmail.com)  [[fb]](https://www.facebook.com/profile.php?id=100008291260780)  [[in]](https://www.linkedin.com/in/maxatma/)
