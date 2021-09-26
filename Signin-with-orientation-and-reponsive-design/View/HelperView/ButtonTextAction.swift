//
//  ButtonTextAction.swift
//  StampBankAdmin
//
//  Created by Waleerat Gottlieb on 2021-07-19.
//

import SwiftUI

struct ButtonTextAction: View {
    
    @Binding var buttonLabel: String
    @State var foregroundColor:Color = Color.white
    @State var backgroundColor:Color = Color.accentColor
    @State var frameWidth: CGFloat = 200
    @State var isActive: Bool = true
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            HStack{
                Text(buttonLabel)
                    .modifier(TextBoldModifier(fontStyle: .common, foregroundColor: foregroundColor))
                    .frame(maxWidth: frameWidth, alignment: .center)
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

struct ButtonTextAction_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTextAction(buttonLabel: .constant("sample button")){
            print("Tapped")
        }
    }
}
