//
//  Ticket.swift
//  Muse
//
//  Created by 유재훈 on 2022/06/13.
//

import SwiftUI

struct Ticket: View {
    
    @Binding var offset: CGFloat
    
    var body: some View {
      VStack{
          ZStack{
              Image("machine")
              
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

            Link(destination: URL(string: "https://music.apple.com/kr/album/dream-like-me/1626442550?i=1626442551/")!) {
                ZStack{
                    Rectangle()
                            .frame(width: 243, height: 60)
                            .opacity(0)
                Image("Play")
                .resizable()
                .frame(width: 32, height: 32)
                .background()
                .clipShape(Circle())
                .foregroundColor(.black)
                }
            }
            .offset(x:0, y:186.5)
            
    }
        .offset(y: -500)
        .animation(Animation.easeInOut(duration: 1.5), value: offset)
        .offset(y: offset)
         
              Rectangle()
                  .frame(width: 300, height: 200)
                  .offset(y:-350)
                  .foregroundColor(.white)
              
              Image("machine2")
                  .offset(x:0, y:-327)
          }
          Button("눌러") {
              withAnimation {
              offset += 500
                  }
              }
}
        
    }
    
}

//struct Ticket_Previews: PreviewProvider {
//    static var previews: some View {
//        Ticket()
//    }
//}
