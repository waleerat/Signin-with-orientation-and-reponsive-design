//
//  UpdateProfileView.swift
//  Signin-with-orientation-and-reponsive-design
//
//  Created by Waleerat Gottlieb on 2021-09-26.
//

import SwiftUI

struct UpdateProfileView: View {
    @ObservedObject var authVM = AuthVM()
    
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
 
    @State var selectionLink:String?
    
    var body: some View {
        VStack {
            Text("Update Profile")
                .modifier(TextBoldModifier(fontStyle: .header))
            
            
            VStack(alignment: .leading, spacing: 10) {
                // Note: - Surname
                Text("Name")
                    .modifier(TextInputModifier())
                HStack(spacing: 15){
                    TextField("Name", text: $name)
                }
                 
                // Note: - Surname
                Text("Surname")
                    .modifier(TextInputModifier())
                HStack(spacing: 15){
                    TextField("Surname", text: $surname)
                }
                
                // Note: - telephone
                Text("Phone Number")
                    .modifier(TextInputModifier())
                HStack(spacing: 15){
                    TextField("Phone Number", text: $telephone)
                }
                 
                // Note: - telephone
                Text("Address")
                    .modifier(TextInputModifier())
                HStack(spacing: 15){
                    TextField("Address", text: $address)
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
 
            
            NavigationLink(destination: HomeView(), tag: "HomeView", selection: $selectionLink) { EmptyView() }
        }
        .padding()
        .background(Color(kScreenBg))
        .cornerRadius(20)
        .padding()
        
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
