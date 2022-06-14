//
//  SearchDataModel.swift
//  Muse
//
//  Created by kwon ji won on 2022/06/14.
//
import Foundation

// https://itunes.apple.com/search?term=coldplay&entity=song
class SearchDataModel { // 네트워크 통신을 위한 클래스
    
    private var dataTask: URLSessionDataTask?
    
    func loadSongs(searchTerm: String, completion: @escaping(([Song]) -> Void)) { // 검색한 내용에 대한 결과를 json으로 불러오는 함수
        dataTask?.cancel()
        guard let url = buildUrl(forTerm: searchTerm) else {
            completion([])
            return
        }
        
        //let session = URLSession(configuration: .default)
        //dataTask = session.dataTask(with: url) { data, _, _ in ...
        dataTask = URLSession.shared.dataTask(with: url) { data1, _, _ in // data, response, error in
            guard let data = data1 else {
                completion([])
                return
            }
            
            if let songResponse = try? JSONDecoder().decode(SongResponse.self, from: data) {
                completion(songResponse.songs)
            }
        }
        dataTask?.resume()
    }
    
    private func buildUrl(forTerm searchTerm: String) -> URL? { // 형식에 맞는 검색 내용을 파라미터로 담은 url 생성 함수
        guard !searchTerm.isEmpty else { return nil }
        
        let queryItems = [ // 파라미터
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "song"),
        ]
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = queryItems
        
        return components?.url
    }
}

struct SongResponse: Decodable {
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey { // 인터넷 검색으로 불러온 json의 키 이름과 사용자가 설정한 이름이 다를때 매칭을 할 수 있도록
        case songs = "results" // 사용자 지정명 : songs, json key명 : result
    }
}

struct Song: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl60"
    }
}
