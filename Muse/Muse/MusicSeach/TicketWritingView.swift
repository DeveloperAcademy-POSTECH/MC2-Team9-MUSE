//
//  TicketWritingView.swift
//  Muse
//
//  Created by kwon ji won on 2022/06/14.
//

//import SwiftUI

//class TicketWritingViewModel: ObservableObject {
//    @Published var trackName: String? = nil
//    @Published var artistName: String? = nil
//    @Published var id : Int? = nil
//    //앨범 불러오기
//    @Published var artwork : Image? = nil
//}
//
//struct TicketWritingView: View {
//    @ObservedObject var viewModel = TicketWritingViewModel()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink {
//                    MusicSearchView(
//                        songListViewModel: SongListViewModel(),
//                        ticketWritingViewModel: viewModel
//                    )
//                } label: {
//                    Text("노래 찾아봐!! 다 찾아주께!")
//                }
//                HStack{
//                    ArtworkView(image: viewModel.artwork)
//                        .padding(.trailing)
//                    VStack(alignment: .leading) {
//                        Text(viewModel.trackName ?? "")
//                        Text(viewModel.artistName ?? "")
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                        Text(String(viewModel.id ?? 0))
//                    }
//                }
//
//            }
//        }
//    }
//}
//
//struct TicketWritingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketWritingView()
//    }
//}
