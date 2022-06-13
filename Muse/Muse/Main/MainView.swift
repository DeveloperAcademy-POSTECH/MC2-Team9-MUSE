//
//  MainView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

struct MainView: View {
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            Color.bgGrey.ignoresSafeArea()
            VStack (spacing: 0){
                Text("Muse Ticket")
                    .font(.custom("Courier New", size: 34, relativeTo: .title))
//relativeTo : 모든 기기마다 title이 갖는 값을 기준으로 34를 변환 시킨다.
                    .padding(.bottom)
                ZStack {
                    Image("machine")
                    //Image("ticket")
                    VStack(spacing:40){
                        Text("뮤즈풀한 음악을 위해 \n티켓을 뽑아보세요.")
                            .font(.custom("Apple SD Gothic Neo Bold",size:20,relativeTo: .title))
                            .foregroundColor(Color(red: 142/255, green: 142/255, blue: 147/255))
                        //RGB를 할때는 255로 나눠야 합니다!!
                            .multilineTextAlignment(.center)
                        //                Text(markdownText)
                        Text(
                        """
                        '\(Text("새 티켓뽑기").underline())'를 터치해
                        랜덤으로 음악 티켓을 받을 수 있어요.
                        
                        '\(Text("티켓저장").underline())'을 터치해
                        마음에 드는 음악과 코멘트를 모아보세요.
                        
                        '\(Text("내 라이브러리").underline())'에서
                        나의 음악티켓을 작성할 수 있어요.
                        """)
                        .font(.custom("Apple SD Gothic Neo Heavy", size: 16, relativeTo: .title))
                        .foregroundColor(Color(red: 142/255, green: 142/255, blue: 147/255))
                        .multilineTextAlignment(.center)
                        
                    }
                }
    
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        print("이동 할꺼랍쇼")
                        //이미지 저장 하는 코드를 짜야합니다.
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 153/255, green: 153/255, blue: 153/255))
                            Text("티켓 저장")
                                .font(.custom("Apple SD Gothic Neo Heavy",size:17,relativeTo: .title))
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    })
                    .frame(width: screenSize.width*0.42, height: screenSize.width*0.07)
                    Button(action: {
                        print("이동 할꺼랍쇼")
                    }, label: {
                        //이미지 저장 하는 코드를 짜야합니다.
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 255/255, green: 102/255, blue: 102/255))
                            Text("새 티켓 뽑기")
                                .font(.custom("Apple SD Gothic Neo Heavy",size:17,relativeTo: .title))
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    })
                    .frame(width: screenSize.width*0.42, height: screenSize.width*0.07)
                            
                }
                .padding(.top, 24)
            }
        }
        . padding(.top, -1)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
