//
//  CommonModifier.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import Foundation
import SwiftUI

    
struct NavigationBarHiddenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .modifier(ScreenModifier())
    }
}

struct ScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg").ignoresSafeArea())
    }
}

struct TextInputModifier : ViewModifier { 
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
            .font(.system(size: getFontSize(fontStyle: .common) ,weight: .regular, design: .rounded))
        .foregroundColor(foregroundColor)
    }
}

struct TextBoldModifier : ViewModifier {
    var fontStyle: FontStyle
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
        .font(.system(size: getFontSize(fontStyle: fontStyle) ,weight: .bold, design: .rounded))
        .foregroundColor(foregroundColor)
    }
}

struct TextRegularModifier : ViewModifier {
    var fontStyle: FontStyle
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
        .font(.system(size: getFontSize(fontStyle: fontStyle) ,weight: .regular, design: .rounded))
        .foregroundColor(foregroundColor)
    }
}

struct TextBoldWithUnderLineModifier : ViewModifier {
    var fontStyle: FontStyle
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
        .font(.system(size: getFontSize(fontStyle: fontStyle) ,weight: .bold, design: .rounded))
        .foregroundColor(foregroundColor)
        //.underline(true, color: Color.white)
    }
}

struct CommonIconModifier: ViewModifier {
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
        content 
            .frame(width: 25, height: 25)
            .foregroundColor(foregroundColor)
    }
}


struct ImageModifier : ViewModifier {
   func body(content: Content) -> some View {
   content
    .aspectRatio(contentMode: .fit)
    .foregroundColor(.accentColor.opacity(0.5))
    .frame(height: screenSize.height * 0.2)
    .cornerRadius(10)
    .modifier(CustomShadowModifier())
   }
}


struct CustomShadowModifier : ViewModifier {
   func body(content: Content) -> some View {
   content
       .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
   }
}
