//
//  Music.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 10/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

class Music {
    var id: Int?
    var readable: Bool?
    var title: String?
    var duration: Int?
    var previewUrl: String?
    var artist: Artist?
    var album: Album?
    
    init(_ dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        readable = dictionary["readable"] as? Bool ?? false
        title = dictionary["title"] as? String ?? ""
        duration = dictionary["duration"] as? Int ?? 0
        previewUrl = dictionary["preview"] as? String ?? ""
        if let artistJson = dictionary["artist"] as? [String: Any] {
            artist = Artist(artistJson)
        }
        if let albumJson = dictionary["album"] as? [String: Any] {
            album = Album(albumJson)
        }
    }
}
