//
//  Ticket.swift
//  Muse
//
//  Created by 유재훈 on 2022/06/13.
//

import SwiftUI
import MessageUI


struct Ticket: View {
    @State private var blockAlert = false
    @ObservedObject var randomSong: TicketWritingViewModel
    @Binding var offset: CGFloat
    @State var isShowAlert = false
    @State var isShowMailView = false
    @State var mailResult: Result<MFMailComposeResult, Error>? = nil
    //    let tarackNameString = String(randomSong.$artistName)
    //
    //    "https://www.youtube.com/results?search_"+randomSong.artistName+" "+randomSong.trackName"
    var body: some View {
        VStack{
            
            ZStack{
                TicketMachineView()
                
                //                ZStack{
                Image("ticket")
                    .overlay {
                        VStack(spacing: 10) {
                            HStack {
                                //                                ArtworkView(image: randomSong.artwork)
                                if let artworkImage = randomSong.artwork {
                                    artworkImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 66, height: 66)
                                    //                                        .padding(.trailing, 15)
                                }
                                
                                VStack(alignment: .leading){
                                    Text(randomSong.trackName)
                                        .font(.headline)
                                        .lineLimit(2)
                                        .minimumScaleFactor(0.1)
                                        .frame(width: 175, alignment: .leading)
                                    HStack {
                                        Text(randomSong.artistName)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.1)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Button {
                                            self.isShowAlert = true
                                        } label: {
                                            Image(systemName: "ellipsis")
                                            //                                        Text("🚨")
                                        }
                                    }
                                    .frame(width: 175)
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 50)
                            
                            Divider()
                                .background(.gray)
                                .frame(width: 245)
                            
                            ScrollView{
                                Text(randomSong.comment)
                                    .font(.callout)
                                    .lineSpacing(4)
                                    .frame(width: 240, alignment: .leading)
                            }
                            .frame(minWidth: 260, maxHeight: .infinity)
                            .padding(.bottom, 10)
                            
                            
                            
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
                            //                        .offset(x:0, y:186.5)
                                 .padding(.top, 35)
                                 .padding(.bottom, 32)
                            
                        }
                    }
                
                //                }
                    .offset(y: -500)
                    .animation(Animation.easeInOut(duration: offset ==  500 ? 1.5 : 0.5), value: offset)
                    .offset(y: offset)
                
                Rectangle()
                    .frame(width: 300, height: 200)
                    .offset(y:-350)
                    .foregroundColor(.white)
                
                Image("machine2")
                    .offset(x:0, y:-325)
                    .padding(.horizontal, 0.6)
                
                VStack{
                    Text("Music Ticket")
                        .font(.custom("Courier New", size: 34, relativeTo: .title)) //relativeTo : 모든 기기마다 title이 갖는 값을 기준으로 34를 변환 시킨다.
                        .padding()
                    Spacer()
                }
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 180, height: 30, alignment: .center)
                .hidden()
            
        }
        //밑에 무언가를 띄우는거!! // 차단 박아!  //alert으로 알림 뜨게 하기
        .confirmationDialog("", isPresented: self.$isShowAlert) {
            Button("차단하기") {
                blockAlert = true
//                randomSong.blockedUsers.append(randomSong.writer)
            }
//            .alert("Alert Title", isPresented: $blockAlert){
//                Button("차단하기", role: .destructive){}
//            } message: {
//                Text("차단시 작성자의 모든 티켓이 차단됩니다.")
//            }
                  
            //신고하기는 빨간색으로 한다.
            Button(role: .destructive) {
                isShowMailView = true
            } label: {
                Text("신고하기")
            }
        }
        .sheet(isPresented: $isShowMailView) {
            MailView(result: $mailResult)
                .alert("Alert Title", isPresented: $blockAlert){
                    Button("차단하기", role: .destructive){}
                } message: {
                    Text("차단시 작성자의 모든 티켓이 차단됩니다.")
                }
            
        }
    }
}
