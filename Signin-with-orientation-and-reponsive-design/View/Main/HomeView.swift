//
//  HomeView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-26.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    @AppStorage("isAuth") private var isAuth: Bool = false
    var authVM = AuthVM()
    
    @State var selectedLink: String?
    
    var body: some View {
        ZStack {
            VStack {
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
                 
                ButtonTextAction(buttonLabel: .constant("Logout")) {
                    authVM.logOutCurrenUser { error in
                        self.isAuth = false
                    }
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .modifier(ScreenModifier())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


//
