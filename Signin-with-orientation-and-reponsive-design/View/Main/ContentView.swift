//
//  ContentView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI

struct ContentView: View {  
    var body: some View { 
            if AuthVM().currentUser() == nil {
                LoginView()
            } else {
                HomeView()
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
