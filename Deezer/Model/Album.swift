//
//  Album.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 10/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class Album {
    
    var id: Int?
    var title: String?
    var link: String?
    var coverSmallUrl: String?
    var coverMediumUrl: String?
    var coverBigUrl: String?
    var coverXlUrl: String?
    var genreId: Int?
    var fans: Int?
    var listMusic: [Music]?
    
    var image: UIImage?
    
    init(_ dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        title = dictionary["title"] as? String ?? ""
        link = dictionary["link"] as? String ?? ""
        coverSmallUrl = dictionary["cover"] as? String ?? ""
        coverMediumUrl = dictionary["cover_medium"] as? String ?? ""
        coverBigUrl = dictionary["cover_big"] as? String ?? ""
        coverXlUrl = dictionary["cover_xl"] as? String ?? ""
        genreId = dictionary["genre_id"] as? Int ?? 0
        fans = dictionary["fans"] as? Int ?? 0
        
        if let jsonArray = dictionary["tracks"] as? [[String: Any]] {
            var listMusicJson = [Music]()
            for music in jsonArray {
                listMusicJson.append(Music(music))
            }
            listMusic = listMusicJson
        }
    }
}
