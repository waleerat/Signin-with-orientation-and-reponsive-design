//
//  Signin_with_orientation_and_reponsive_designApp.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI
import Firebase

@main
struct Signin_with_orientation_and_reponsive_designApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isAuth") private var isAuth: Bool = false
    init(){
        setupFirebaseApp()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !isAuth {
                    ContentView()
                } else {
                    HomeView()
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    // Note: - connect to Firebase function by Google-Service-info
    private func setupFirebaseApp() {
       guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
                      let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
                  if FirebaseApp.app() == nil{
                      FirebaseApp.configure(options: options)
                  }
    
    }

}
