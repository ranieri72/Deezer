//
//  ArtistCollectionViewCell.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 03/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(artist: Artist) {
        //imageView.image = artist.pictureUrl
        lbName.text = artist.name
    }
}
