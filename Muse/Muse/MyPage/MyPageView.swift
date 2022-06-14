//
//  MypageView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var service: SessionServiceImpl
    
    var body: some View {
        VStack{
            Text("내 라이브러리 뷰!")
            
            AuthButton(title: "LogOut",
                       background: .blue,
                       foreground: .white,
                       border: .clear) {
                service.logout()
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
