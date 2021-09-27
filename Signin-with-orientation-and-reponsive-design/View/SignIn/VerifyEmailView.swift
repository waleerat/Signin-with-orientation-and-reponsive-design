//
//  VerifyEmailView.swift
//  StampBankAdmin
//
//  Created by Waleerat Gottlieb on 2021-08-11.
//

import SwiftUI

struct VerifyEmailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var signupViaEmailVM = SignupViaEmailVM()

    @Binding var selectionLink:String? 
    
    @State var checkIsOnboard:Bool = false
    @State var CountTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var count = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Verified email")
                    .modifier(TextBoldModifier(fontStyle: .header))
                 
                Image(systemName: "envelope")
                    .resizable()
                    .modifier(ImageModifier())
                
                Text("Go to your email account and click verfiy")
                    .modifier(TextRegularModifier(fontStyle: .title))
                
                Text("Note: This screend will be closed in \(30 - (count * 3)) second")
                    .modifier(TextRegularModifier(fontStyle: .common))
                
                ButtonTextAction(buttonLabel: .constant("Close"), backgroundColor: Color.gray.opacity(0.7)) {
                    self.presentationMode.wrappedValue.dismiss()
                } 
            } //: VSTACK
            .padding(.horizontal)
            .padding(.vertical, 40)
            .cornerRadius(10)
            .modifier(CustomShadowModifier())
                
            .onChange(of: checkIsOnboard , perform: { _ in
                // Note: - if Onboard == true then cancel Count Timemer
                if checkIsOnboard {
                    self.CountTimer.upstream.connect().cancel()
                    selectionLink = "UpdateProfileView"
                    //showVerifyEmailView = false
                }
            })
            .onReceive(CountTimer) { _ in
                // Note: - If Onboard == false then check verify again
                if signupViaEmailVM.isVerifyEmail {
                    checkIsOnboard = true
                } else {
                    signupViaEmailVM.CheckIsVerifyEmail()
                }
                // Note: - Try 7 times then dissmiss view
                count += 1
                if count == 10 {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
        .modifier(NavigationBarHiddenModifier())
 
    }
}
