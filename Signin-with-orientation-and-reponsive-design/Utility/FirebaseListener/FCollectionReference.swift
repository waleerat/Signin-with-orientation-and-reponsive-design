//
//  FCollectionReference.swift
//  LetsMeet
//
//  Created by David Kababyan on 30/06/2020.
//

import Foundation
import Firebase


enum FCollectionReference: String {
    case User = "pia_user" 
} 

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
