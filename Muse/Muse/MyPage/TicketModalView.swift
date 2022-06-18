//
//  TicketModalView.swift
//  Muse
//
//  Created by kelly on 2022/06/17.
//

import SwiftUI

struct TicketModalView: View {
    @ObservedObject var clickedSong: TicketWritingViewModel
    @Binding var showing: Bool
    
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Button {
                    withAnimation {
                        showing = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.title)
                }
            }
            .frame(width: 300, height: 50)
            
            VStack {
                HStack(spacing: 20) {
                    ArtworkView(image: clickedSong.artwork)
                        .frame(width: 66, height: 66)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(clickedSong.trackName)
                            .font(.headline)
                            .padding(.vertical, 5)
                            .lineLimit(1)
                        Text(clickedSong.artistName)
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
                    Text(clickedSong.comment)
                }
                .frame(width: 240, height: 190)
                .padding(.vertical)
                
                Spacer()
                
                let _ = print("https://www.youtube.com/results?search_query=\(clickedSong.artistName)+\(clickedSong.trackName)")
                Link(destination: URL(string: "https://www.youtube.com/results?search_query=\(clickedSong.artistNameString)+\(clickedSong.trackNameString)")
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
                .padding(.bottom, 21)
            }
            .frame(width: 280, height: 460)
            .background(
                Image("ticket")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 480)
            )
        }
        // 이스터에그.. 이거 있으면 코멘트 랜덤 애니메이션 나와요
//        .animation(Animation.easeInOut(duration: 2))
        
    }
}
    //
    //struct TicketModalView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        TicketModalView()
    //    }
    //}
