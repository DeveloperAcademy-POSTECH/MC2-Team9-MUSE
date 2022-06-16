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
            
            Image("logoImage")
                .resizable()
                .frame(width: 107, height: 33, alignment: .center)
                .padding(.bottom, -10)
            
            Text("회원가입")
                .frame(width: 348, height: 41, alignment: .center)
                .font(.system(size: 34, weight: .bold))
                
            
            Text("이메일")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color.black)
                .frame(width: 246, height: 44, alignment: .leading)
                .padding(.bottom, -30)
                .padding(.top, 30)
            
            AuthTextField(text: $viewModel.newUser.email,
                          placeholder: "omu@naver.com",
                          keyboardType: .emailAddress,
                          sfSymbol: "envelope")
            
            Text("비밀번호")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color.black)
                .frame(width: 246, height: 44, alignment: .leading)
                .padding(.bottom, -30)
                .padding(.top, -20)
            
            PwdTextFeild(password: $viewModel.newUser.password,
                         placeholder: "6자리 이상 입력해주세요",
                         sfSymbol: "lock")
            
            VStack(spacing:10){
                
                AuthButton(title: "가입하기",
                           background: .customPink,
                           foreground: .white,
                           border: .customPink) {
                    viewModel.create()
                }
                           .padding(.top, 30)
                
                
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
