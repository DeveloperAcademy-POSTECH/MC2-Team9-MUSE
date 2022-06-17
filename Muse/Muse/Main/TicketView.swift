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
//    let tarackNameString = String(randomSong.$artistName)
//
//    "https://www.youtube.com/results?search_"+randomSong.artistName+" "+randomSong.trackName"
    var body: some View {
        VStack{
            
            ZStack{
                TicketMachineView()
                
                ZStack{
                    Image("ticket")
                    HStack{
                        ArtworkView(image: randomSong.artwork)
                            .frame(width: 40, height: 40)
                            .offset(x:40,y:-180)
                        
                        VStack(alignment: .leading){
                            Text(randomSong.trackName )
                                .font(.headline)
                                .frame(width: 175, alignment: .leading)
                                .offset(x:50,y:-175)
                            Text(randomSong.artistName )
                                .font(.subheadline)
                                .frame(width: 175, alignment: .leading)
                                .offset(x:50,y:-175)
                                .foregroundColor(.gray)
                            Divider()
//                                .background(Color.black)
                                .background(.gray)
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
                    
                    
                    let _ = print("https://www.youtube.com/results?search_query=\(randomSong.artistName)+\(randomSong.trackName)")
//                    let _ = print("randomSong.trackName \(randomSong.trackName)")
                    
                    Link(destination: URL(string: "https://www.youtube.com/results?search_query=\(randomSong.artistNameString)+\(randomSong.trackNameString)")
                         ?? URL(string: "https://www.youtube.com/results?search_query=TAYHEON+Why")!) {
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
//s`1qaza`
//
