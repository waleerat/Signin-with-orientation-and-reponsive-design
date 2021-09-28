//
//  UserModel.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-26.
//
 
import Foundation 

class UserModel {
    
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    var phoneNumber: String
    var fullAddress: String?
    var onBoarding: Bool
    var signupWith : String
    var token : String
    let registeredDate = Date()
    
    // initializer for login Via Social Media
    init(_id: String, _email: String, _firstName: String, _lastName: String, _phoneNumber: String, _onBoarding:Bool,_signupWith:String,_token: String) {
        id = _id
        email = _email
        firstName = _firstName
        lastName = _lastName
        fullName = firstName + " " + lastName
        phoneNumber = _phoneNumber
        onBoarding = _onBoarding
        signupWith = _signupWith
        token = _token
    }
     
    init(_ dictionary : NSDictionary) {
        id = dictionary[kID] as? String ?? ""
        email = dictionary[kEMAIL] as? String ?? ""
        firstName = dictionary[kFIRSTNAME] as? String ?? ""
        lastName = dictionary[kLASTNAME] as? String ?? ""
        fullName = firstName + " " + lastName
        fullAddress = dictionary[kFULLADDRESS] as? String ?? ""
        phoneNumber = dictionary[kPHONENUMBER] as? String ?? ""
        onBoarding = dictionary[kONBOARD] as? Bool ?? false
        signupWith = dictionary[kSIGNUPWITH] as? String ?? ""
        token = dictionary[kTOKEN] as? String ?? ""
    }
    
    // MARK: - DICTIONARY FORM
    class func userDictionaryFrom(user: UserModel) -> [String : Any] {
     
     return NSDictionary(objects: [user.id,
                                   user.email,
                                   user.firstName,
                                   user.lastName,
                                   user.fullName,
                                   user.fullAddress ?? "",
                                   user.phoneNumber,
                                   user.onBoarding,
                                   user.signupWith,
                                   user.token
                                 ],
                         forKeys: [kID as NSCopying,
                                   kEMAIL as NSCopying,
                                   kFIRSTNAME as NSCopying,
                                   kLASTNAME as NSCopying,
                                   kFULLNAME as NSCopying,
                                   kFULLADDRESS as NSCopying,
                                   kPHONENUMBER as NSCopying,
                                   kONBOARD as NSCopying,
                                   kSIGNUPWITH as NSCopying,
                                   kTOKEN as NSCopying
     ]) as! [String : Any]
     
    }
    
    
    class func dictionaryToStructure(_ rowData:  [String : Any]) -> UserModel {
        return UserModel(
            _id: rowData[kID] as! String,
            _email: rowData[kEMAIL] as! String,
            _firstName: rowData[kFIRSTNAME] as! String,
            _lastName: rowData[kLASTNAME] as! String,
            _phoneNumber: rowData[kPHONENUMBER] as! String,
            _onBoarding:rowData[kONBOARD] as! Bool,
            _signupWith:rowData[kSIGNUPWITH] as! String,
            _token: rowData[kTOKEN] as! String
        )
    }
 
}
