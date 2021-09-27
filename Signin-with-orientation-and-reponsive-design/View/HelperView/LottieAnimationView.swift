//
//  lottieAnimationView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    @State var lottieFileName: String
    
    func makeUIView(context: Context) -> AnimationView{
        
        let view = AnimationView(name: lottieFileName, bundle: Bundle.main) // /Resource login.json
        
        // on Complete....
        view.play { (status) in
            
        }
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
        
    }
}
