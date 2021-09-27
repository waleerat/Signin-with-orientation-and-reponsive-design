//
//  UpdateProfileView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-26.
//

import SwiftUI

struct UpdateProfileView: View {
    @AppStorage("isPortrait") private var isPortrait: Bool = false
    
    @ObservedObject var authVM = AuthVM()
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
 
    @State var selectionLink:String?
    
    var body: some View {
        ZStack {
            VStack {
                Text("Update Profile")
                    .modifier(TextBoldModifier(fontStyle: .header))
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    // Note: - Surname
                    Text("Name")
                        .modifier(TextBoldModifier(fontStyle: .common))
                    HStack(spacing: 15){
                        TextField("Name", text: $name)
                            .modifier(TextInputModifier())
                    }
                     
                    // Note: - Surname
                    Text("Surname")
                        .modifier(TextBoldModifier(fontStyle: .common))
                    HStack(spacing: 15){
                        TextField("Surname", text: $surname)
                            .modifier(TextInputModifier())
                    }
                    
                    // Note: - telephone
                    Text("Phone Number")
                        .modifier(TextBoldModifier(fontStyle: .common))
                    HStack(spacing: 15){
                        TextField("Phone Number", text: $telephone)
                            .modifier(TextInputModifier())
                    }
                     
                    // Note: - telephone
                    Text("Address")
                        .modifier(TextBoldModifier(fontStyle: .common))
                    HStack(spacing: 15){
                        TextField("Address", text: $address)
                            .modifier(TextInputModifier())
                    }
                    
                }
                
                Button {
                    SaveToFirebase()
                } label: {
                    HStack{
                        Text("Update Profile")
                            .modifier(TextBoldModifier(fontStyle: .common, foregroundColor: .white))
                            .frame(maxWidth: 120, alignment: .center)
                    }
                    .padding(.vertical,13)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(iserifyCompleted() ? Color.blue : Color.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white,lineWidth: 1)
                            )
                    )
                }
                .disabled(!iserifyCompleted())
                Spacer()
                NavigationLink(destination: HomeView(), tag: "HomeView", selection: $selectionLink) { EmptyView() }
            }//:VStack
            
            .background(Color.accentColor.opacity(0.2))
            .padding()
            .cornerRadius(10)
            
            
        }
        .modifier(NavigationBarHiddenModifier())
    }

    // Note: - Helper Function
    func iserifyCompleted() -> Bool{
        return self.name != "" && self.surname != ""
    }
    
   private func SaveToFirebase() {
       let fullName = name + " " + surname
       authVM.updateCurrentUser(
        withValues: [kFIRSTNAME : name,
                    kLASTNAME : surname,
                    kFULLNAME : fullName,
                    kFULLADDRESS : address,
                    kPHONENUMBER : telephone,
                    kONBOARD : true
                    ]) { (error) in
           
           if error != nil {
               print("error updating user: ", error!.localizedDescription)
               return
           }
                        selectionLink = "HomeView"
       }
   }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
