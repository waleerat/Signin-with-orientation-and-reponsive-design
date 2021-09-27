# Firebase Email Authentication 
### Xcode Version 13.0
###### SwiftUI, Firebase


### How to install

1. Download project to your Mac
<img src="https://github.com/waleerat/GitHub-Photos-Shared/main/Signin-with-orientation-and-reponsive-design/download-xcode.png" width="70%" height="70%">

2. Setup firebase `https://firebase.google.com/docs/ios/setup`

3. Import your own GoogleService-Info.plist

4. run pod install in Terminal
```sh
 run pod install
```
5. Close project and open again 
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Finder.png" width="50%" height="50%">

6. ✨Well done, now you will be able to see the CMS screen.
Finder.png
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Lanscape.png" width="50%" height="50%"> | <img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Lanscape2.png" width="50%" height="50%">

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/portrait.png" width="50%" height="50%"> | <img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/portrait1.png" width="50%" height="50%">



### Setup Scene Delegate
When you create a new SwiftUI project with Xcode 13 you may notice it doesn’t have an Info.plist file. 

1. Go to Application Scene Minifest  -> Scene Configuration -> Application Role
2. Delete Class Name  put `$(PRODUCT_MODULE_NAME).SceneDelegate`
3. Configuration Name  put  `Default Configuration`  

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/Signin-with-orientation-and-reponsive-design/Application-Section-Role" width="50%" height="50%">



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

