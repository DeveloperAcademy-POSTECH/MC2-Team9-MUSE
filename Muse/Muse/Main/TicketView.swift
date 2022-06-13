//
//  Ticket.swift
//  Muse
//
//  Created by 유재훈 on 2022/06/13.
//

import SwiftUI

struct Ticket: View {
    var body: some View {
        ZStack{
                Image("ticket")
              
            HStack{
                Image("Album")
                    .resizable()
                    .frame(width: 66, height: 66)
                    .offset(x:40,y:-180)
            VStack(alignment: .leading){
                Text("Dreams Like Me")
                        .font(.headline)
                    .offset(x:50,y:-180)
                Text("Black Skirt")
                    .offset(x:50,y:-170)
                
                //텍스트 길어질때 자동 줄바꿈 하는법?
                Divider()
                    .background(Color.black)
                    .frame(width: 250)
                    .offset(x:-40,y:-150)
                }
            }
            
            ScrollView{
                Text("안녕하세요 제 이름은 검정치마........... 안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........")
            }
                .frame(width: 260, height: 200)
            //데이터 어떻게?
            Link(destination: URL(string: "https://music.apple.com/kr/album/dream-like-me/1626442550?i=1626442551/")!) {
                ZStack{
                    Rectangle()
                            .frame(width: 243, height: 60)
                            .opacity(0)
                Image("Play")
            //컬러 검은색?
                .resizable()
                .frame(width: 32, height: 32)
                .background()
                .clipShape(Circle())
                }
            }
            .offset(x:0, y:186.5)
            .foregroundColor(.black)
                
    }
}
}
struct Ticket_Previews: PreviewProvider {
    static var previews: some View {
        Ticket()
    }
}
