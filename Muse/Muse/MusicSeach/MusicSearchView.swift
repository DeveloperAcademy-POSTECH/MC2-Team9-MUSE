//
//  MusicSearchView.swift
//  Muse
//
//  Created by kwon ji won on 2022/06/14.
//
import SwiftUI

struct MusicSearchView: View {
    @ObservedObject var songListViewModel: SongListViewModel
    var ticketWritingViewModel: TicketWritingViewModel
    //네비게이션 뷰를 지우기 위한 환경설정
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //        NavigationView {
        VStack {
            SearchBar(searchTerm: $songListViewModel.searchTerm)
                .padding(.horizontal)
            if songListViewModel.songs.isEmpty {
                EmptyStateView()
            } else {
                List(songListViewModel.songs) { song in
                    Button {
                        dismiss()
                        self.ticketWritingViewModel.artwork = song.artwork
                        self.ticketWritingViewModel.artworkUrl = song.artworkUrl
                        self.ticketWritingViewModel.musicId = song.id
                        self.ticketWritingViewModel.trackName = song.trackName
                        self.ticketWritingViewModel.artistName = song.artistName
                        
                    } label: {
                        SongView(song: song)
                        //                        .onTapGesture {
                        
                        //                            self.presentationMode2.wrappedValue.dismiss()
                        
                        //                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle("Music Search")
        //      .navigationBarHidden(true)
        //      .ignoresSafeArea()
        //        }
    }
}

struct SongView: View {
    @ObservedObject var song: SongViewModel
    
    var body: some View {
        HStack {
            ArtworkView(image: song.artwork)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct ArtworkView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Image("")
                Color(.systemIndigo)
//                Image(systemName: "music.note")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
            }
        }
        .frame(width: 50, height: 50)
//        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "music.note.list")
                .font(.system(size: 80))
                .padding(.bottom)
                .foregroundColor(Color.customPink)
            
            Text("소개하고 싶은 음악을 \n검색해주세요")
                .font(.title3)
                .foregroundColor(Color.customPink)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.customPink)
    }
}

// UIViewRepresentable : UIkit 뷰를 감싸 SwiftUI에서 사용하게 해주는 wrapper
struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "곡, 가수, 앨범명 등"
        // 한글로 변경?
        // "Type a song, artist, or album name..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

struct MusicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MusicSearchView(songListViewModel: SongListViewModel(), ticketWritingViewModel: TicketWritingViewModel())
    }
}
