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
            
            Image("logoImage")
                .resizable()
                .frame(width: 166, height: 51, alignment: .center)
                .padding()
                .padding(.top, -30)
            
            
            Text("Our Music Universe,")
                .font(.body)
                .fontWeight(.medium)
                .padding(.bottom, -15)
            
            Text("오뮤에 오신 걸 환영합니다.")
                .font(.body)
                .fontWeight(.medium)
                .padding(.bottom, 60)
            
            
            AuthTextField(text: $viewModel.credentials.email,
                          placeholder: "이메일을 입력해주세요",
                          keyboardType: .emailAddress,
                          sfSymbol: "envelope")
            .padding(.bottom, -5)
            
            PwdTextFeild(password: $viewModel.credentials.password,
                         placeholder: "비밀번호를 입력해주세요",
                         sfSymbol: "lock")
            .padding(.bottom, 10)
            
            AuthButton(title: "로그인",
                       background: .customPink,
                       foreground: .white,
                       border: .white) {
                viewModel.login()
            }
                       .padding(.bottom, -10)
            
            HStack{
                // 기존의 회원가입 버튼을 text로 변경
                Text("계정이 없으신가요?")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color.gray)
                
                Text("회원가입")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color.customPink)
                    .fontWeight(.bold)
                    .padding(.horizontal, -3)
                    .onTapGesture {
                        showRegistration.toggle()
                    }
                    .sheet(isPresented: $showRegistration) {
                        RegisterView()
                    }
            }.frame(width: 230, height: 20, alignment: .trailing)
            
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login")
        
        //            .alert(isPresented: $viewModel.hasError,
        //                   content: {
        //
        //                if case .failed(let error) = viewModel.state {
        //                    return Alert(
        //                        title: Text("Error"),
        //                        message: Text(error.localizedDescription))
        //                } else {
        //                    return Alert(
        //                        title: Text("Error"),
        //                        message: Text("Something went wrong"))
        //                }
        //            })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
