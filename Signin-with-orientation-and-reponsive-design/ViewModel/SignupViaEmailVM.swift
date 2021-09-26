//
//  EmailLoginVM.swift
//  StampBankAdmin
//
//  Created by Waleerat Gottlieb on 2021-08-20.
//

import SwiftUI
import Firebase

// MARK: - Sign Via email
class SignupViaEmailVM: ObservableObject {
    @AppStorage("isAuth") private var isAuth: Bool = false
    @ObservedObject var authVM = AuthVM()
    public var isVerifyEmail:Bool = false
    
    func registerUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
       // Note: - Register Email to Firebase Authen
       Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
           completion(error)
           if error == nil {
               authResult!.user.sendEmailVerification { (error) in
                   print("verification email sent error is: ", error?.localizedDescription ?? "Unknown")
               }
           }
       }
   }
   
   func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
      // Note: - If verified email then get user data from user default
      Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
          if error == nil {
              if authResult!.user.isEmailVerified {
                self.authVM.downloadUserFromFirestore(userId: authResult!.user.uid, email: email) { (error) in
                    self.isAuth = true
                    completion(error, true)
                  }
              } else {
                  completion(error, false)
              }
          } else {
              completion(error, false)
          }
      }
  }
    
    func CheckIsVerifyEmail(){
        self.emailVerifiedListener()
    }
    
    func emailVerifiedListener(){
        // Note: - Reload Authen
        Auth.auth().currentUser?.reload(completion: { (error) in
             
        })
        // Note: - Check if onBoard then set Onboard status to True
        authVM.handle = Auth.auth().addStateDidChangeListener { (auth, authResult) in
            if let result = authResult {
               DispatchQueue.main.async {
                self.isVerifyEmail = result.isEmailVerified ? true : false
                if self.isVerifyEmail {
                    self.authVM.OnbardingStatusOn()
                   }
                }
            }
        }
    }
   
   func resetPassword(email: String, completion: @escaping (_ error: Error?) -> Void) {
       // Note: - set request reset password via email
       Auth.auth().sendPasswordReset(withEmail: email) { (error) in
           completion(error)
       }
   }
   
   func resendVerificationEmail(email: String, completion: @escaping (_ error: Error?) -> Void) {
       
       Auth.auth().currentUser?.reload(completion: { (error) in
           
           Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
               
               completion(error)
           })
       })
   }
}
