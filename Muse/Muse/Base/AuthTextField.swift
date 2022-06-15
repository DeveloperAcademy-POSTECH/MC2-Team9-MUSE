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
            TextField("이메일을 입력해주세요", text: $text)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(Color.gray)
                .padding(.leading, 20)
                .frame(width: 246, height: 44, alignment: .center)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 100)
                .stroke()
                .frame(width: 246, height: 44, alignment: .center)
                .foregroundColor(Color.customPink)
        }
        .padding(.bottom, -5)
    }
}

struct PwdTextFeild: View {
    
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String
    
    var body: some View {
        HStack{
            SecureField("비밀번호를 입력해주세요", text: $password)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(Color.gray)
                .padding(.leading, 20)
                .frame(width: 246, height: 44, alignment: .center)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 100).stroke()
                .frame(width: 246, height: 44, alignment: .center)
                .foregroundColor(Color.customPink)                
        }
        .padding(.bottom, 20)
    }
}

//struct AuthTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthTextField()
//    }
//}
