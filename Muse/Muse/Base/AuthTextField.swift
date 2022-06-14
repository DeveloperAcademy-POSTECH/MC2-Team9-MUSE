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
            Image(systemName: "heart")
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading, 20)
                .foregroundColor(.gray)
            TextField("a", text: $text)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.red)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, minHeight: 50)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundColor(.blue)
        }
    }
}

struct PwdTextFeild: View {
    
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String
    
    var body: some View {
        HStack{
            Image(systemName: "heart")
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading, 20)
                .foregroundColor(.gray)
            SecureField("a", text: $password)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.red)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, minHeight: 50)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundColor(.blue)
        }
    }
}

//struct AuthTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthTextField()
//    }
//}
