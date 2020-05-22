# Walkie-Talkie

Video Calls Application that implements WebRTC power for video calls. 


<p align="center">
 <img src="https://user-images.githubusercontent.com/7135226/82156823-ccbb2a80-98a7-11ea-8c33-64f8e2a2ae77.png" width="40%">
 <img src="https://user-images.githubusercontent.com/7135226/82156829-dcd30a00-98a7-11ea-86ae-42db1f4a03ef.png" width="40%">
 </p>
 
 
## Technologies used:

 - Language: Swift 5
 - Main Architectural pattern: MVVM + Router 
 - Dependency manager: CocoaPods 
 - Network:
      WebRTC: GoogleWebRTC
      Signaling: Firebase/Firestore
 - UI: Xib, Autolayout, UIStackView
 - Reactive Programming: ReactiveKit + Bond
 - Object JSON Mapping: Codable


## Functionality description:

- Create room by entering ID and pressing "create"
- Provide you ID to callee and make him enter ID and press "join"
- Choose source for video stream - camera or default videofile
- Choose previous room IDs you have used
- Your video goes in picture-in-picture
- Tap to hide all but caller video
- Press settings buttons for mic/sound/video on/off
- Enjoy video call 


You can use WebRTCClient and SignalingClient classes to make your own video call project. To do that create Firebase project and put your GoogleService-Info.plist file into it.
Don't forget to call FirebaseApp.configure() in AppDelegate


## Contacts

Oleksandr Zaporozhchenko
[[github]](https://github.com/Maxatma)  [[gmail]](mailto:maxatma.ids@gmail.com)  [[fb]](https://www.facebook.com/profile.php?id=100008291260780)  [[in]](https://www.linkedin.com/in/maxatma/)
