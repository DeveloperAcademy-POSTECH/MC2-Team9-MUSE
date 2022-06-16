//
//  Ticket.swift
//  Muse
//
//  Created by 유재훈 on 2022/06/13.
//

import SwiftUI


struct Ticket: View {

    @ObservedObject var randomSong: TicketWritingViewModel
    @Binding var offset: CGFloat
    
    var body: some View {
        VStack{
        
            ZStack{
                TicketMachineView()
                
                ZStack{
                    Image("ticket")
                    HStack{
                        ArtworkView(image: randomSong.artwork)
                            .frame(width: 66, height: 66)
                            .offset(x:40,y:-180)
                        
                        VStack(alignment: .leading){
                            Text(randomSong.trackName )
                                .font(.headline)
                                .frame(width: 190, alignment: .leading)
                                .offset(x:50,y:-180)
                                
                            Text(randomSong.artistName )
                                .font(.subheadline)
                                .frame(width: 180, alignment: .leading)
                                .offset(x:50,y:-170)
                            Divider()
                                .background(Color.black)
                                .frame(width: 250)
                                .offset(x:-40,y:-150)

                        }
                    }
                    
                    ScrollView{
                        Text(randomSong.comment )
                            .font(.callout)
                            .frame(width: 235, alignment: .leading)
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
                .animation(Animation.easeInOut(duration: offset ==  500 ? 1.5 : 0.5), value: offset)
                .offset(y: offset)
                
                Rectangle()
                    .frame(width: 300, height: 200)
                    .offset(y:-350)
                    .foregroundColor(.white)
                
                Image("machine2")
                    .offset(x:0, y:-327)
                
                VStack{
                    Text("Muse Ticket")
                                        .font(.custom("Courier New", size: 34, relativeTo: .title)) //relativeTo : 모든 기기마다 title이 갖는 값을 기준으로 34를 변환 시킨다.
                                        .padding()
                    Spacer()
                }
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 180, height: 30, alignment: .center)
                .hidden()
//            Button("눌러") {
//                if offset == 500 {
//                    offset = 0
//                }
//                withAnimation {
//                    offset += 500
//                    //                  offset += (offset == 0) ? 500 : -500
//                }
//            }
        }

    }
}


//
//struct Ticket_Previews: PreviewProvider {
//    static var previews: some View {
//        Ticket()
//    }
//}
//
