//
//  TicketMachineView.swift
//  Muse
//
//  Created by Admin on 2022/06/14.
//

import SwiftUI

struct TicketMachineView: View {
    @Binding var flag: Bool
    @Binding var offset: CGFloat
    
    var body: some View {
        ZStack {
            Image("machine")
                .resizable()
                .scaledToFit()
            
            VStack(spacing:40){
                Text("뮤즈풀한 음악을 위해\n티켓을 뽑아보세요.")
                    .font(.custom("Apple SD Gothic Neo SemiBold",size:20,relativeTo: .title))
                    .foregroundColor(Color(red: 142/255, green: 142/255, blue: 147/255))
                //RGB를 할때는 255로 나눠야 합니다!!
                    .multilineTextAlignment(.center)
                Text(
                """
                '\(Text("새 티켓 뽑기").underline())'를 터치해
                랜덤으로 음악 티켓을 받을 수 있어요.
                
                '\(Text("티켓 저장").underline())'을 터치해
                마음에 드는 음악과 코멘트를 모아보세요.
                
                '\(Text("내 라이브러리").underline())'에서
                나의 음악 티켓을 작성할 수 있어요.
                """)
                .font(.custom("Apple SD Gothic Neo", size: 16, relativeTo: .title))
                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                .multilineTextAlignment(.center)
            }
            if flag {
                TicketView(offset: $offset)
            }
        }
        .padding(.horizontal)
    }
}

struct TicketMachineView_Previews: PreviewProvider {
    static var previews: some View {
        TicketMachineView(flag: .constant(true), offset: .constant(0.0))
    }
}
