//
//  CarouselModel.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import Foundation

struct CarouselModel: Identifiable,Hashable {
    var id: String
    let imageAsset: String
    var topic:String
    var description:String
}


var Carousels: [CarouselModel] = [
    CarouselModel(id: UUID().uuidString, imageAsset: "apple", topic: "Do you know?", description: "When you create a new SwiftUI project with Xcode 13 you may notice it doesn’t have an Info.plist file."),
    CarouselModel(id: UUID().uuidString, imageAsset: "gmail", topic: "To detact orientation we need Scene Delegate", description: """
But you need to set in Info.plist.

How to fix this issue?
you can find the setting on my git repository.
"""),
    CarouselModel(id: UUID().uuidString, imageAsset: "email", topic: "Thank you", description: "Enjoy your learning")
]
 
