//
//  AuthVM.swift
//  StampBankAdmin
//
//  Created by Waleerat Gottlieb on 2021-07-20.
//


import SwiftUI
import Firebase

class AuthVM: ObservableObject {
    @Published var userInfo: UserModel?
    @Published var isOnboard:Bool = false
    @Published var showAlertMessage: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertDecription: String = ""
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        loadCurrentUser()
    }
    
    func loadCurrentUser()  {
        userInfo = currentUser()
    }
    
    private func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
     func currentUser() -> UserModel? {
        if Auth.auth().currentUser != nil {
            if let dictionary = kUserDefault.object(forKey: kCURRENTUSER) {
                return UserModel.init(dictionary as! NSDictionary)
            }
        }
        return nil
    }
    
    func checkIsOnBoarding() -> Bool{
        if let dictionary = kUserDefault.object(forKey: kCURRENTUSER) {
            return UserModel.init(dictionary as! NSDictionary).onBoarding
        } else {
            return false
        }
    }
    
    func OnbardingStatusOn() {
        // Note: - After Verify Email then save user data to fire store with onBoarding = true
        let auth = Auth.auth().currentUser
        if auth != nil {
            let userData = UserModel(_id: auth!.uid, _email: auth!.email!, _firstName: "", _lastName: "", _phoneNumber: "", _onBoarding: true, _signupWith: "Email", _token: "")
            self.updateUser(user: userData)
            
        }
    }
    
    /* Check if update user informations */
    func checkIsCompleteProfile() -> Bool {
        if currentUser() != nil {
            if currentUser()!.firstName == "" {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    // MARK: - LOGOUT
     func logOutCurrenUser(completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut() 
            // Note: - Remove data from userDefaults
            kUserDefault.removeObject(forKey: kCURRENTUSER)
            kUserDefault.synchronize()
            completion(nil)
        } catch {
            return
        }
    }
     
     func updateCurrentUser(withValues: [String : Any], completion: @escaping (_ error: Error?) -> Void) {
     // Note: - Create/Update user if Onbarding = true (Check in process)
        if let dictionary = kUserDefault.object(forKey: kCURRENTUSER) {
         let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
         userObject.setValuesForKeys(withValues)
         FirebaseReference(.User).document(currentId()).updateData(withValues) { (error) in
             
             completion(error)
             if error == nil {
                self.saveUserLocally(userDictionary: userObject)
             }
         }
     }
    }
    
    func updateUser(user: UserModel) {
        self.saveUserLocally(userDictionary: UserModel.userDictionaryFrom(user: user) as NSDictionary)
        self.saveUserToFirestore(fUser: user)
    }
    
    private func saveUserLocally(userDictionary: NSDictionary) {
        kUserDefault.set(userDictionary, forKey: kCURRENTUSER)
        kUserDefault.synchronize()
    }
    
    func downloadUserFromFirestore(userId: String, email: String, completion: @escaping (_ error: Error?) -> Void) {
     // Note: - this function action only if email has been verified
     FirebaseReference(.User).document(userId).getDocument { (snapshot, error) in
         
         guard let snapshot = snapshot else { return }
         
         if snapshot.exists {
            
            self.saveUserLocally(userDictionary: snapshot.data()! as NSDictionary)
         } else {
            let userData = UserModel(_id: userId, _email: email, _firstName: "", _lastName: "", _phoneNumber: "", _onBoarding: false, _signupWith: "Email", _token: "")
            self.updateUser(user: userData)
         }
         completion(error)
     }
    }
    
    func saveUserToFirestore(fUser: UserModel) {
        let dictionaryData = UserModel.userDictionaryFrom(user: fUser) as NSDictionary
       FirebaseReference(.User).document(fUser.id).setData(dictionaryData as! [String : Any]) { (error) in
            if error != nil {
                print("Error creating fuser object: ", error!.localizedDescription)
            }
        }
   }

}

