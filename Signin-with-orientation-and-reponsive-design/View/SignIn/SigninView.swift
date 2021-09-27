//
//  SigninButtonsView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import SwiftUI

struct SigninView: View {
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
        SigninView(isShowSigninForm: .constant(false))
    }
}


struct LoginForm: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    @ObservedObject var authVM = AuthVM()
    @ObservedObject var signupViaEmailVM = SignupViaEmailVM()
    
    @Binding var isShowSigninForm:Bool
    @Binding var isSignup:Bool
    
    @State var show = false
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    // Note: - Helper variable
    @State var showAlertMessage:Bool = false
    @State var alertMessage = ""
    
    @State var selectionLink:String?
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                // Note: - input email
                Text("Email")
                    .modifier(TextBoldModifier(fontStyle: .common))
                    
                HStack(spacing: 15){
                    TextField("Enter Email", text: $email)
                        .modifier(TextInputModifier())
                }
                Divider().background(Color.white)
                // Note: - input Password
                Text("Password")
                    .modifier(TextBoldModifier(fontStyle: .common))
                HStack(spacing: 15){
                    SecureField("Enter a password", text: $password)
                        .modifier(TextInputModifier())
                }
                Divider().background(Color.white)
                
                // Note: - input replete password
                if isSignup {
                    Text("Replete Password")
                        .modifier(TextBoldModifier(fontStyle: .common))
                    HStack(spacing: 15){
                        SecureField("Enter a password", text: $repeatPassword)
                            .modifier(TextInputModifier())
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color("frame-bg"))
        .cornerRadius(10)
        .modifier(CustomShadowModifier())
 
        
        NavigationLink(destination: HomeView(), tag: "HomeView", selection: $selectionLink) { EmptyView() }
        
        NavigationLink(destination: VerifyEmailView(selectionLink: $selectionLink), tag: "VerifyEmailView", selection: $selectionLink) { EmptyView() }
        
        NavigationLink(destination: UpdateProfileView(), tag: "UpdateProfileView", selection: $selectionLink) { EmptyView() }
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
                    selectionLink = "VerifyEmailView"
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
                        selectionLink = "VerifyEmailView"
                    } else {
                        if !authVM.checkIsOnBoarding() {
                            selectionLink = "VerifyEmailView"
                        } else if !authVM.checkIsCompleteProfile() {
                            selectionLink = "UpdateProfileView"
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

 
