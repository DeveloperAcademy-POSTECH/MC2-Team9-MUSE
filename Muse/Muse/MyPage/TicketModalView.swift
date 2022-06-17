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
                    showing = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.title)
                }
            }
            .frame(width: 300, height: 50)
            
            ZStack{
                Image("ticket")
                    .shadow(color: .black, radius: 30, x: 0, y: 0)
                
                VStack {
                    
                    HStack{
                        ArtworkView(image: clickedSong.artwork)
                            .frame(width: 66, height: 66)
                        
                        VStack(alignment: .leading){
                            Text(clickedSong.trackName )
                                .font(.headline)
                                .frame(width: 190, alignment: .leading)
                            
                            Text(clickedSong.artistName )
                                .font(.subheadline)
                                .frame(width: 180, alignment: .leading)
                            Divider()
                                .background(Color.black)
                                .frame(width: 250)
                            
                        }
                    }
                    
                    ScrollView{
                        Text(clickedSong.comment )
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
                }
            }
            
        }
        .animation(Animation.easeInOut(duration: 2))
        
    }
}
    //
    //struct TicketModalView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        TicketModalView()
    //    }
    //}
