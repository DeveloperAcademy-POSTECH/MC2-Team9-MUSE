//
//  Ticket.swift
//  Muse
//
//  Created by 유재훈 on 2022/06/13.
//

import SwiftUI

struct TicketView: View {
    
    @Binding var offset: CGFloat
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Image("Album")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 66, height: 66)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Dreams Like Me")
                        .font(.headline)
                        .padding(.vertical, 5)
                        .lineLimit(1)
                    Text("Black Skirt")
                        .padding(.vertical, 5)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding(.top)
            .padding(.bottom, 10)
            .frame(width: 240)
            
            Divider()
                .background(Color.black)
                .frame(width: 240)
            
            ScrollView{
                Text("안녕하세요 제 이름은 검정치마........... 안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........안녕하세요 제 이름은 검정치마...........")
            }
            .frame(width: 240, height: 190)
            .padding(.vertical)
            
            Spacer()
            
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
            .padding(.bottom, 21)
        }
        .frame(width: 280, height: 460)
        .background(
            Image("ticket")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 480)
        )
        .offset(y: -500)
        .animation(Animation.easeInOut(duration: 1.5), value: offset)
        .offset(y: offset)        
    }
    
}
struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(offset: .constant(0.0))
    }
}
