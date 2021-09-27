//
//  CarouselModel.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import Foundation

struct CarouselModel: Identifiable,Hashable {
    var id: String
    var topic:String
    var description:String
}


var Carousels: [CarouselModel] = [
    CarouselModel(id: UUID().uuidString,  topic: "Do you know?", description: "When you create a new SwiftUI project with Xcode 13 you may notice it doesn’t have an Info.plist file."),
    CarouselModel(id: UUID().uuidString, topic: "To detact orientation", description: """
We need set Scene Delegate in Info.plist. you can find the setting on my git repository. 
"""),
    CarouselModel(id: UUID().uuidString, topic: "Thank you", description: "Enjoy your learning")
]
 
