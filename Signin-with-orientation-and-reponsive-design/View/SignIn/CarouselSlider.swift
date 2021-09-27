//
//  sliderItem.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-25.
//

import SwiftUI

struct CarouselSlider: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    
    @State var currentIndex : Int = 1
    @State var show:Bool = false
    var body: some View {
        VStack {
            TabView(selection: $currentIndex){
                SliderItem(currentIndex: $currentIndex)
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
             
            CustomTabIndicator(count: 3, current: $currentIndex)
                .padding(.vertical,isSmallDevice ? 10 : 15)
                .padding(.top)
        }
        
    }
}


struct SliderItem: View{
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    
    @Binding var currentIndex: Int
   
    
    var body: some View{
         
        ForEach(1...Carousels.count,id: \.self){ index in
            // For Cusotm Scroll Effect...
            GeometryReader{proxy -> AnyView in
                
                let minX = proxy.frame(in: .global).minX
                
                var width: CGFloat {
                    if isPortrait {
                        return screenSize.width
                    } else {
                        return screenSize.width / 1.8
                    }
                }
                
                
                let progress = -minX / (width * 2)
                
                var scale = progress > 0 ? 1 - progress : 1 + progress
                
                scale = scale < 0.7 ? 0.7 : scale
                
                return AnyView(
                
                    VStack{
                        Image(Carousels[index - 1].imageAsset)
                            .resizable()
                            .scaledToFit()
                            .frame(width: isIpad ? 400 : 200)
                        
                        Text(Carousels[index - 1].topic)
                            .modifier(TextBoldModifier(fontStyle: .header))
                            .padding(.horizontal)
                            .padding(.top,20)
                        
                        Text(Carousels[index - 1].description)
                            .modifier(TextBoldModifier(fontStyle: .description))
                            .padding(.horizontal)
                            .padding(.top,10)
                    }
                    .padding(.top,isSmallDevice ? 10 : 0)
                    //.frame(maxHeight: .infinity, alignment: .center)
                    .scaleEffect(scale)
                )
            }
           
            .tag(index)
             
        }
    }
    
    
}


struct CustomTabIndicator: View {
    
    var count: Int
    @Binding var current: Int
    
    var body: some View{
        
        HStack{
            
            ForEach(0..<count,id: \.self){index in
                
                ZStack{
                    
                    // since our image index starts from 1...
                    if (current - 1) == index{
                        
                        Circle()
                            .fill(Color.black)
                    }
                    else{
                        
                        Circle()
                            .fill(Color.white)
                            .overlay(
                            
                                Circle()
                                    .stroke(Color.black,lineWidth: 1.5)
                            )
                    }
                }
                .frame(width: 10, height: 10)
            }
        }
    }
}
