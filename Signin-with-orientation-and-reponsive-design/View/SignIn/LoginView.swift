//
//  Landscape.swift
//  SwiftUI-device-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    @State var isShowSigninForm: Bool = false
    
    var body: some View {
        
        ZStack {
            if isPortrait {
                VStack{
                    // Note: - Carousel SLider...
                    CarouselSlider()
                    // Login Buttons....
                    SigninButtonsView(isShowSigninForm: $isShowSigninForm) 
                }
            } else {
                HStack{
                    // Note: - Carousel SLider...
                    CarouselSlider()
                    // Login Buttons....
                    SigninButtonsView(isShowSigninForm: $isShowSigninForm)
                }
            }
        }.modifier(ScreenModifier()) 
        
    }
}

struct Landscape_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
