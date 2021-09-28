# Firebase Signup via Email
### Xcode Version 13.0
###### SwiftUI, Firebase

Example for signup via email, verify email, update profile with orientation and responsive design.

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/workflow.png" width="70%" height="70%">

## How to install

1. Download project to your Mac
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/download-xcode.png" width="70%" height="70%">

2. Setup firebase `https://firebase.google.com/docs/ios/setup`

3. Import your own GoogleService-Info.plist

4. run pod install in Terminal
```sh
 run pod install
```
5. Close project and open again 
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Finder.png" width="50%" height="50%">

6. ✨Well done, now you will be able to see the CMS screen.


<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Lanscape1.png" width="30%" height="30%"> | <img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Lanscape2.png" width="30%" height="30%">

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/portrait.png" width="20%" height="20%"> | <img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/portrait2.png?raw=true" width="20%" height="20%">



## Setup Scene Delegate
When you create a new SwiftUI project with Xcode 13 you may notice it doesn’t have an Info.plist file. 

1. Go to Application Scene Minifest  -> Scene Configuration -> Application Role
2. Delegate Class Name  put `$(PRODUCT_MODULE_NAME).SceneDelegate`
3. Configuration Name  put  `Default Configuration`  

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Application-Section-Role.png" width="80%" height="80%">



### plist.info

```sh
 <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>UIApplicationSceneManifest</key>
    <dict>
        <key>UIApplicationSupportsMultipleScenes</key>
        <false/>
        <key>UISceneConfigurations</key>
        <dict>
            <key>UIWindowSceneSessionRoleApplication</key>
            <array>
                <dict>
                    <key>UISceneConfigurationName</key>
                    <string>Default Configuration</string>
                    <key>UISceneDelegateClassName</key>
                    <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                </dict>
            </array>
        </dict>
    </dict>
</dict>
</plist>
```

## Check these files

#### SceneDelegate.swift

Line 7 : [Read about @AppStorage]: <https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-appstorage-property-wrapper>
```sh 
@AppStorage("isPortrait") private var isPortrait: Bool = false
``` 
Line 1-12 : Get orientation when the app loaded
```sh
   if let windowScene = scene as? UIWindowScene {
         self.isPortrait = getOrientation(scene: windowScene)
   }
```
Line 18 : Get orientation when you rotate the phone
```sh
self.isPortrait = getOrientation(scene: windowScene)
```
#### Signin_with_orientation_and_reponsive_designApp.swift

Line 13 : 
```sh 
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
````

Line 15-17 : 
```sh
  init(){
        setupFirebaseApp()
  }
```

Line 21-27
```sh
            NavigationView {
                if AuthVM().currentUser() == nil {
                    ContentView()
                } else {
                    HomeView()
                }
            }.navigationViewStyle(StackNavigationViewStyle())
```

Line 32 - 40
if you want to separate to difference Firebase for development and production so you can use this code otherwise you can just use  `FirebaseApp.configure()`

```sh
    private func setupFirebaseApp() {
       guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
                      let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
                  if FirebaseApp.app() == nil{
                      FirebaseApp.configure(options: options)
                  }
    
    }
```
    
Example for Config 2 difference Firebase.
    
```sh
     private func setupFirebaseApp() {
        #if DEBUG
            let kGoogleServiceInfoFileName = "DEVELOPMENT-GoogleService-Info"
        #else
            let kGoogleServiceInfoFileName = "GoogleService-Info"
        #endif
        
       guard let plistPath = Bundle.main.path(
        forResource: kGoogleServiceInfoFileName, ofType: "plist"),
             let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
        
          if FirebaseApp.app() == nil{
              FirebaseApp.configure(options: options)
          }
    }
```
 
#### ContentView.swift
The landing screen for the app
`AuthVM().currentUser()` check if user loged in or not.

Line 12-16 :
```sh
    if AuthVM().currentUser() == nil {
        AuthenticationView()
    } else {
        HomeView()
    }
```


#### FCollectionReference.swift
Collections for firebase

````sh
enum FCollectionReference: String {
    case User = "pia_user" 
} 

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
} 
````
How to use 
```sh
FirebaseReference(.User).document(objectId).delete() { error in }
```

#### DeviceProperties.swift
The common propertiy of variables for iPhone and iPad. 

#### Constants.swift
The variables that I use in the project. 
ex. fields name for dictionary because if you change fields name later you can change here as well as coller setting in Assest.

#### EmailLoginVM.swift
This file use for authentication user via email. You should separate file for google and facebook. In my opinioin, it makes your life easier to imprement.

#### AuthVM.swift
This file for checking authentication status.

#### UserModel.swift
The model for User Collection.
