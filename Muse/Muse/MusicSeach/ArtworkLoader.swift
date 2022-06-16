//
//  ArtworkLoader.swift
//  Muse
//
//  Created by kwon ji won on 2022/06/14.
//
import Foundation
import SwiftUI

class ArtworkLoader {
  private var dataTasks: [URLSessionDataTask] = []
  
  func loadArtwork(forSong song: String, completion: @escaping((Image?) -> Void)) {
      print("hey~~~~")
      print(song)
    guard let imageUrl = URL(string: song) else {
        print("in err")
      completion(nil)
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
      guard let data = data, let artwork = UIImage(data: data) else {
          print("in err")
        completion(nil)
        return
      }
      
      let image = Image(uiImage: artwork)
      completion(image)
    print("성공")
    }
    dataTasks.append(dataTask)
    dataTask.resume()
  }

  func reset() {
    dataTasks.forEach { $0.cancel() }
    dataTasks.removeAll()
  }
}
