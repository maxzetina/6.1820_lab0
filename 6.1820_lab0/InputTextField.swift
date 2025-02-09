//
//  InputTextField.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/7/25.
//


import SwiftUI

struct InputTextField: View {
    var placeholderText: String
    var width: CGFloat = 300
    @Binding var input: String
    var img: Image?
    var autocapitalize = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10).frame(width: width, height: 50).foregroundColor(.gray).opacity(0.25).overlay(
            HStack{
                if(img != nil){
                    img.padding(.leading)
                }
                if(autocapitalize){
                    TextField(placeholderText, text: $input)   .disableAutocorrection(true)
                        .padding(.leading, img != nil ? 4.0 : 12.0)
                }
                else{
                    TextField(placeholderText, text: $input)   .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.leading, img != nil ? 4.0 : 12.0)
                }
            }
        ).padding(.bottom, 4.0)
    }
}

#Preview {
    InputTextField(placeholderText: "placeholder", width: 300, input: .constant("Some Input"), img: Image(systemName: "person.fill"))

}
