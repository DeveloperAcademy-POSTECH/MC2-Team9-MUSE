//
//  TicketListView.swift
//  Muse
//
//  Created by Admin on 2022/06/13.
//

import SwiftUI

struct TicketListView: View {
    var isMyTicket: Bool
    @State var change: Bool = true
    
    @Binding var tickets: [TicketWritingViewModel]
    @State private var showing = false
    @State var clicked = TicketWritingViewModel()
    
    let loader = ArtworkLoader()
    
    @ViewBuilder
    func ticketButton(song: TicketWritingViewModel) -> some View {
        Button {
            loader.loadArtwork(forSong: song.artworkUrl){ img in
                song.artwork = img
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                clicked = TicketWritingViewModel(song.trackName, song.artistName, song.musicId, song.comment, song.artworkUrl, song.artwork, song.writer, song.downloadNum)
                
                withAnimation{
                    showing = true
                }
            }
        } label: {
            HStack (spacing: 5) {
                // 곡 제목 - 가수 VStack
                VStack(alignment: .leading, spacing: 0) {
                    Text(song.trackName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .padding(.top, 7)
                    Text(song.artistName)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                        .padding(.top, 3)
//                    HStack {
//                        Text(song.artistName)
//                            .font(.callout)
//                            .multilineTextAlignment(.leading)
//                            .lineLimit(1)
//                            .foregroundColor(.gray)
//                            .padding(.top, 3)
//                        Spacer()
//                        Button {
//                            guard let index = tickets.firstIndex(of: song) else { return }
//                            tickets.remove(at: index)
//                        } label: {
//                            Text("🗑")
//                        }
//                    }
                }
                Spacer()
                // 조건문으로 받아오는 데이터 타입에 따라(저장한 티켓에서는) 아래 내용 표시 X
                if !isMyTicket {
                    Image(systemName: "square.and.arrow.down")
                    Text(String(song.downloadNum))
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .foregroundColor(.black)
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                    Spacer() // 리스트 거꾸로 돌리려고..
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity, alignment: Alignment.topLeading)
                    ForEach(tickets) { song in
                        // 카드 리스트 Vstack
                        VStack (alignment: .center, spacing: 0) {
                            // 카드 내 Content HStack
                            ticketButton(song: song)
                        }
                        //                    .frame(width: 350, height: 100, alignment: .top)
                        .frame(width: 350, height: 120, alignment: .top)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.5), radius: 2)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, -20)
                .frame(maxWidth: .infinity)
                .rotationEffect(Angle(degrees: 180)) // 리스트 거꾸로 돌릴려고..
            }
            .rotationEffect(Angle(degrees: 180)) // 리스트 거꾸로 돌릴려고..
            
            if showing {
                TicketModalView(clickedSong: clicked, tickets: $tickets, showing: $showing)
                //.animation(Animation.easeInOut(duration: 2))
            }
        }
    }
    
    
}
