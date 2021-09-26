//
//  IconAndTextButtonAction.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import SwiftUI

struct IconAndTextButtonAction: View {
    var imageAsset:String?
    var systemName:String?
    var text:String
    var foregroundColor: Color = .white
    var backgroundColor: Color = .accentColor
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            HStack{
                if let imageAsset = imageAsset {
                    Image(imageAsset)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .modifier(CommonIconModifier(foregroundColor: foregroundColor)) 
                }
                
                if let systemName = systemName {
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .modifier(CommonIconModifier(foregroundColor: foregroundColor))
                }
                
                Text(text)
                    .modifier(TextBoldModifier(fontStyle: .common, foregroundColor: foregroundColor))
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding(.vertical,13)
            .padding(.horizontal)
            .background(
            
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
                    .overlay(
                    
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(foregroundColor,lineWidth: 1)
                    )
            )
        })
    }
}

 
/*
 struct CommonIconButtonAction: View {
     var imageAsset:String?
     var systemName:String?
     //@Binding var foregroundColor: Color?
     @Binding var isActive: Bool
     
     var action: () -> Void
     var body: some View {
         Button(action: action , label: {
             if let imageAsset = imageAsset {
                 Image(imageAsset)
                     .resizable()
                     .modifier(CommonIconModifier(isActive: .constant(true)))
             }
             
             if let systemName = systemName {
                 Image(systemName: systemName)
                     .resizable()
                     .modifier(CommonIconModifier(isActive: .constant(true)))
             }
         })
     }
 }

  

 */
