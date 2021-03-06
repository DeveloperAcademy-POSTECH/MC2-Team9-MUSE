//
//  AuthTextField.swift
//  Muse
//
//  Created by kelly on 2022/06/13.
//

import SwiftUI

struct AuthTextField: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String
    
    var body: some View {
        HStack{
            Image(systemName: sfSymbol)
                .padding(.leading, 70)
//                .font(.system(size: 13, weight: .regular))
                .font(.subheadline)
                .foregroundColor(Color.gray)
            TextField(placeholder, text: $text)
//                .font(.system(size: 13, weight: .regular))
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .frame(width: 286, height: 44, alignment: .center)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
        }
        .overlay {
//            RoundedRectangle(cornerRadius: 100)
            Capsule()
                .stroke()
                .frame(width: 286, height: 44, alignment: .center)
                .foregroundColor(Color.customPink)
        }
    }
}

struct PwdTextFeild: View {
    
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String
    
    var body: some View {
        HStack{
            Image(systemName: sfSymbol)
                .padding(.leading, 70)
//                .font(.system(size: 13, weight: .regular))
                .font(.subheadline)
                .foregroundColor(Color.gray)
            SecureField(placeholder, text: $password)
//                .font(.system(size: 13, weight: .regular))
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .frame(width: 286, height: 44, alignment: .center)
        }
        .overlay {
//            RoundedRectangle(cornerRadius: 100)
            Capsule()
                .stroke()
                .frame(width: 286, height: 44, alignment: .center)
                .foregroundColor(Color.customPink)                
        }
    }
}

//struct AuthTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthTextField()
//    }
//}
