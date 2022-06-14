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
        
        NavigationView {
            
            VStack(spacing: 32) {
                
                VStack(spacing: 16) {
                    
                    AuthTextField(text: $viewModel.newUser.nickName,
                                  placeholder: "First Name",
                                  keyboardType: .namePhonePad,
                                  sfSymbol: "lock")
                    
                    AuthTextField(text: $viewModel.newUser.email,
                                  placeholder: "Email",
                                  keyboardType: .emailAddress,
                                  sfSymbol: "envelope")
                    
                    PwdTextFeild(password: $viewModel.newUser.password,
                                 placeholder: "Password",
                                 sfSymbol: "lock")
                    
                    Divider()
                    
                    Button {
                        presenationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    //
                    //                    Picker("Gender", selection: $viewModel.newUser.gender) {
                    //                        ForEach(Gender.allCases) { item in
                    //                            Text(item.rawValue)
                    //                        }
                    //                    }
                }
                
                AuthButton(title: "Sign Up",
                           background: .clear,
                           foreground: .blue,
                           border: .blue) {
                    viewModel.create()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Register")
            //            .applyClose() 
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
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
