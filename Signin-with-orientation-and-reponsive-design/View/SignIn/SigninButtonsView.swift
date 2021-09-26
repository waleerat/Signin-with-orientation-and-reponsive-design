//
//  SigninButtonsView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import SwiftUI

struct SigninButtonsView: View {
    @Binding var isShowSigninForm:Bool
    @State var isSignup:Bool = false
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 15){
                
                IconAndTextButtonAction(imageAsset: "email",
                                        text: "Sign up with Email    ",
                                        foregroundColor: Color.white,
                                        backgroundColor: Color.green.opacity(0.7)
                                        , action: {
                    
                    isSignup = true
                    isShowSigninForm = true
                })
                
                IconAndTextButtonAction(systemName: "applelogo",
                                        text: "Sign up with Apple  ",
                                        foregroundColor: Color.black,
                                        backgroundColor: Color.white
                                        , action: {
                    
                    print("Sign up with Apple")
                })
                
                IconAndTextButtonAction(imageAsset: "google",
                                        text: "Sign up with Google",
                                        foregroundColor: Color.white,
                                        backgroundColor: Color.red.opacity(0.7)
                                        , action: {
                    
                    print("Sign up with Google")
                })
                 
                HStack{
                    
                    Text("Already have an account?")
                        .modifier(TextRegularModifier(fontStyle: .common, foregroundColor: .white))
                     
                    Button(action: {
                        isSignup = false
                        isShowSigninForm = true
                    }, label: {
                        Text("Login")
                            //.fontWeight(.semibold)
                            .font(.system(size: getFontSize(fontStyle: .common) ,weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .underline(true, color: Color.white)
                           //.modifier(TextBoldWithUnderLineModifier(fontStyle: .common, foregroundColor: .white))
                    })
                }
                .padding(.top,30)
            }//: VSTACK
            .onChange(of: isSignup, perform: { newValue in
                print("Chagen to \(isSignup)")
            })
            .blur(radius: isShowSigninForm ? 8.0 : 0, opaque: false) 
            .padding()
            
            
            if isShowSigninForm {
                LoginForm(isShowSigninForm: $isShowSigninForm, isSignup: $isSignup)
            } 
        }//:ZSTACK
        
    }
}

struct SigninButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SigninButtonsView(isShowSigninForm: .constant(false))
    }
}
