//
//  ResisterView.swift
//  Muse
//
//  Created by kelly on 2022/06/13.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presenationMode
    
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl()
    )
    
    var body: some View {
        VStack(spacing: 32) {
                
                AuthTextField(text: $viewModel.newUser.email,
                              placeholder: "Email",
                              keyboardType: .emailAddress,
                              sfSymbol: "envelope")
                
                PwdTextFeild(password: $viewModel.newUser.password,
                             placeholder: "Password",
                             sfSymbol: "lock")
            
            AuthButton(title: "Sign Up",
                       background: .customPink,
                       foreground: .white,
                       border: .customPink) {
                viewModel.create()
            }
            
            
            Button {
                presenationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Text("괜찮아요, 다음에 할게요")
                        .frame(width: 246, height: 44, alignment: .center)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color.gray)
                        .padding(.leading, 20)
                }
                .overlay{
                    RoundedRectangle(cornerRadius: 100)
                        .stroke()                    
                        .frame(width: 246, height: 44, alignment: .center)
                        .foregroundColor(Color.gray)
                }                
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Register")
        .alert(isPresented: $viewModel.hasError,
               content: {
            
            if case .failed(let error) = viewModel.state {
                return Alert(
                    title: Text("Error"),
                    message: Text(error.localizedDescription))
            } else {
                return Alert(
                    title: Text("Error"),
                    message: Text("Something went wrong"))
            }
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
