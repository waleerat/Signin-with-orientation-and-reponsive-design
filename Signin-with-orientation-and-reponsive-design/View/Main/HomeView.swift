//
//  HomeView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-26.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    @ObservedObject var authVM = AuthVM()
    @State var selectionLink: String?
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // Note: - LaxyVGrid  : isPortrait ? 2 : 4
                Text("Rotate Screen to see what difference")
                    .modifier(TextBoldModifier(fontStyle: .title))
                Spacer()
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: isPortrait ? 2 : 4), alignment: .center, spacing: 10) {
                    ForEach(1...12,id: \.self){ index in
                        HStack {
                            Text("Column \(index)")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.pink.opacity(0.5))
                    }
                }
                 
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: isPortrait ? 1 : 2), alignment: .center, spacing: 10) {
                    
                    ButtonTextAction(buttonLabel: .constant("Update Profile"),backgroundColor: Color.green.opacity(0.7)) {
                        selectionLink = "UpdateProfileView"
                    }
                    
                    ButtonTextAction(buttonLabel: .constant("Logout"),backgroundColor: Color.green.opacity(0.7)) {
                        authVM.logOutCurrenUser { error in
                            selectionLink = "ContentView"
                        }
                    } 
                }
                
                Spacer()
                
            }
            .padding()
            
            NavigationLink(destination: ContentView(), tag: "ContentView", selection: $selectionLink) { EmptyView() }
            NavigationLink(destination: UpdateProfileView(), tag: "UpdateProfileView", selection: $selectionLink) { EmptyView() }
        }
        .modifier(NavigationBarHiddenModifier())
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


//
