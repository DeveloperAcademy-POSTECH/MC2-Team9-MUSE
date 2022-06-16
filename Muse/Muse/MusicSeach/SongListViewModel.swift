//
//  SongListViewModel.swift
//  Muse
//
//  Created by kwon ji won on 2022/06/14.
//

import SwiftUI


import Combine
import Foundation
import SwiftUI

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongViewModel] = []
    
    private let dataModel: SearchDataModel = SearchDataModel()
    private let artworkLoader: ArtworkLoader = ArtworkLoader()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        artworkLoader.reset()
        //[weak self]를 통해 강한 참조가 아닌 약한 참조를 사용할 수 있도록
        dataModel.loadSongs(searchTerm: searchTerm) { [weak self] results in // dataModel의 loadSongs 함수의 검색결과가 @escaping 클로저를 통해 전달됨 (-> results)
            print(results)
            results.forEach { self?.appendSong(song: $0) } // loadSongs 함수에서 인터넷에서 불러온 데이터를 그 후에 이 클로저를 실행. (appendSong 힘수 호출)
        }
    }
    
    private func appendSong(song: Song) { // appendSong 함수를 통해 self의 songs 배열에 매개변수로 들어온 song들을 차례로 append
        let songViewModel = SongViewModel(song: song)
        DispatchQueue.main.async { // 이 부분을
            self.songs.append(songViewModel)
        }
        
        artworkLoader.loadArtwork(forSong: song.artworkUrl) { image in
            DispatchQueue.main.async {
                songViewModel.artwork = image
            }
        }
    }
}

class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    @Published var artwork: Image?
    
    init(song: Song) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
        self.artworkUrl = song.artworkUrl
    }
}
