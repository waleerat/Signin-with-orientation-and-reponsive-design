//
//  lottieAnimationView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    @Binding var show: Bool
    @State var lottieFileName: String
    
    func makeUIView(context: Context) -> AnimationView{
        
        let view = AnimationView(name: lottieFileName, bundle: Bundle.main) // /Resource login.json
        
        // on Complete....
        view.play { (status) in
            
            if status{
                
                // toggling view...
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    show.toggle()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
        
    }
}
