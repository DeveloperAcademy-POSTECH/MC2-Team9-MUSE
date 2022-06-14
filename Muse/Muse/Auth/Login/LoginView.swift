//
//  LoginView.swift
//  Muse
//
//  Created by kelly on 2022/06/13.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegistration = false
//        @State private var showForgotPassword = false
    
        @StateObject private var viewModel = LoginViewModelImpl(
            service: LoginServiceImpl()
        )
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            AuthTextField(text: $viewModel.credentials.email,
                          placeholder: "Email",
                          keyboardType: .emailAddress,
                          sfSymbol: "envelope")
            
            PwdTextFeild(password: $viewModel.credentials.password,
                          placeholder: "Password",
                         sfSymbol: "lock")
            
            AuthButton(title: "Login",
                       background: .clear,
                       foreground: .blue,
                       border: .blue) {
                viewModel.login()
            }
            
            AuthButton(title: "Register",
                       background: .clear,
                       foreground: .blue,
                       border: .blue) {
                showRegistration.toggle()
            }
            .sheet(isPresented: $showRegistration) {
                RegisterView() 
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login")
//        .alert(isPresented: $viewModel.hasError,
//               content: {
//
//            if case .failed(let error) = viewModel.state {
//                return Alert(
//                    title: Text("Error"),
//                    message: Text(error.localizedDescription))
//            } else {
//                return Alert(
//                    title: Text("Error"),
//                    message: Text("Something went wrong"))
//            }
//        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
