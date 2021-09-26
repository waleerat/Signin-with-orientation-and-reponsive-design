//
//  LoginForm.swift
//  SwiftUI-device-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI

struct LoginForm: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    @ObservedObject var authVM = AuthVM()
    @ObservedObject var signupViaEmailVM = SignupViaEmailVM()
    
    @Binding var isShowSigninForm:Bool
    @Binding var isSignup:Bool
    
    @State var show = false
    @State var email = "waleerat.sang@gmail.com"
    @State var password = "1234567890"
    @State var repeatPassword = "1234567890"
    
    // Note: - Helper variable
    @State var showVerifyEmailView: Bool = false
    @State var showCompleateProfileView: Bool = false
    @State var showAlertMessage:Bool = false
    @State var alertMessage = ""
    
    @State var selectionLink:String?
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                // Note: - input email
                Text("Email")
                    .modifier(TextInputModifier())
                    
                HStack(spacing: 15){
                    TextField("Input Email", text: $email)
                }
                Divider().background(Color.white)
                // Note: - input Password
                Text("Password")
                    .modifier(TextInputModifier())
                HStack(spacing: 15){
                    TextField("Input Password", text: $password)
                }
                Divider().background(Color.white)
                
                // Note: - input replete password
                if isSignup {
                    Text("Replete Password")
                        .modifier(TextInputModifier())
                    HStack(spacing: 15){
                        TextField("Input replete password", text: $repeatPassword)
                    }
                    Divider().background(Color.white)
                }
                 
            }//:VStack
            
            HStack {
                ButtonTextAction(
                    buttonLabel: isSignup ? .constant("Signup") : .constant("Signin"),
                    foregroundColor: Color.white,
                    backgroundColor: Color.green.opacity(0.7),
                    frameWidth: 120,
                    isActive: true
                ) {
                    // Note: - signup or signin user
                   self.isSignup ? self.signupUser() : self.signinUser()
                }
                
                
                ButtonTextAction(
                    buttonLabel: .constant("Cancel"),
                    foregroundColor: Color.white,
                    backgroundColor: Color.gray,
                    frameWidth: 120,
                    isActive: true
                ) {
                    isShowSigninForm = false
                }
            }
            .alert(isPresented: $showAlertMessage) {
                    Alert(title: Text("Some thing went wrong!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
                        
            
        }//:VStack
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .modifier(CustomShadowModifier())
           
        
        if showVerifyEmailView {
            VerifyEmailView(showVerifyEmailView: $showVerifyEmailView, showCompleateProfileView: $showCompleateProfileView)
        }
        
        NavigationLink(destination: HomeView(), tag: "HomeView", selection: $selectionLink) { EmptyView() }

    }
    
    // MARK: - Helper Function
    func signupUser(){
        if email != "" && password != "" && repeatPassword != ""  &&
            HelperFunction.validatorEmail(email) &&
            (password == repeatPassword ){
            signupViaEmailVM.registerUserWith(email: email, password: password) { (error) in
                if error != nil {
                    self.alertMessage = " \n\(error!.localizedDescription) \n"
                    self.showAlertMessage.toggle()
                    return
                } else { 
                    self.showVerifyEmailView = true
                }
            }
            return
        }
    }
 
    private func signinUser() {
       if email != "" && password != "" {
           signupViaEmailVM.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                if error != nil {
                    self.alertMessage = " \n\(error!.localizedDescription) \n"
                    self.showAlertMessage.toggle()
                } else {
                    if !isEmailVerified {
                        self.showVerifyEmailView = true
                    } else {
                        if !authVM.checkIsOnBoarding() {
                            self.showVerifyEmailView = true
                        } else if !authVM.checkIsCompleteProfile() {
                            self.showCompleateProfileView = true
                        } else {
                            selectionLink = "HomeView" 
                        }
                    }
                }
            }
       } else {
           self.alertMessage = " \nEmail or Password is empty\n"
      
        self.showAlertMessage.toggle()
       }
        
    }
}

 
