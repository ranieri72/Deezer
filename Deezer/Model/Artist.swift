//
//  Artist.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 03/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class Artist {
    
    var id: Int?
    var name: String?
    var link: String?
    var pictureSmallUrl: String?
    var pictureMediumUrl: String?
    var pictureBigUrl: String?
    var pictureXlUrl: String?
    var albums: Int?
    var fans: Int?
    var radio: Bool?
    var listMusic: [Music]?
    
    var image: UIImage?
    
    init(_ dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        link = dictionary["link"] as? String ?? ""
        pictureSmallUrl = dictionary["picture"] as? String ?? ""
        pictureMediumUrl = dictionary["picture_medium"] as? String ?? ""
        pictureBigUrl = dictionary["picture_big"] as? String ?? ""
        pictureXlUrl = dictionary["picture_xl"] as? String ?? ""
        albums = dictionary["nb_album"] as? Int ?? 0
        fans = dictionary["nb_fan"] as? Int ?? 0
        radio = dictionary["radio"] as? Bool ?? false
    }
}
