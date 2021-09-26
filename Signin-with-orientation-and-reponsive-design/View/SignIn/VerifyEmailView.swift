//
//  VerifyEmailView.swift
//  StampBankAdmin
//
//  Created by Waleerat Gottlieb on 2021-08-11.
//

import SwiftUI

struct VerifyEmailView: View {
  //  @ObservedObject var authVM = AuthVM()
    @ObservedObject var signupViaEmailVM = SignupViaEmailVM()

    @Binding var showVerifyEmailView:Bool
    @Binding var showCompleateProfileView:Bool
    
    @State var checkIsOnboard:Bool = false
    @State var CountTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var selectionLink : String?
    
    var body: some View {
        
        VStack(spacing: 16) {
            if !checkIsOnboard {
                Text("Verified email")
                    .modifier(TextBoldModifier(fontStyle: .title))
                 
                Text("Go to your email account and click verfiy")
                    .modifier(TextRegularModifier(fontStyle: .title))
                
                  IconAndTextButtonAction(systemName: "xmark",
                                          text: "Close", backgroundColor: Color.gray) {
                    // Note: - Code here
                    showVerifyEmailView = false
                }
            } else {
                Text("Done!! You have verified email")
                    .modifier(TextBoldModifier(fontStyle: .title))
                 
                Text("Please update your profile.")
                    .modifier(TextRegularModifier(fontStyle: .title))
                
                
                IconAndTextButtonAction(systemName: "xmark",
                     text: "Close", backgroundColor: Color.gray) {
                  // Note: - Code here
                  showVerifyEmailView = false
              }
            }
        
        } //: VSTACK
        .padding(.horizontal)
        .padding(.vertical, 40)
        .background(Color.white)
        .cornerRadius(10)
        .modifier(CustomShadowModifier())
            
        .onChange(of: checkIsOnboard , perform: { _ in
            if checkIsOnboard {
                self.CountTimer.upstream.connect().cancel()
                selectionLink = "UpdateProfileView"
                //showVerifyEmailView = false
                print(">> Go to UpdateProfileView")
            }
        })
        .onReceive(CountTimer) { _ in
            if signupViaEmailVM.isVerifyEmail {
                checkIsOnboard = true
            } else {
                signupViaEmailVM.CheckIsVerifyEmail()
            }
            
        }
            //: VSTACK Frame
        NavigationLink(destination: UpdateProfileView(), tag: "UpdateProfileView", selection: $selectionLink) { EmptyView() }
    }
}
