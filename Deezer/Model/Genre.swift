//
//  Genre.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 08/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

class Genre {
    var id: Int?
    var name: String?
    var pictureUrl: String?
    var pictureMediumUrl: String?
    var pictureBigUrl: String?
    var listArtists: [Artist]?
    
    init(_ dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        pictureUrl = dictionary["picture"] as? String ?? ""
        pictureMediumUrl = dictionary["picture_medium"] as? String ?? ""
        pictureBigUrl = dictionary["picture_big"] as? String ?? ""
    }
}
