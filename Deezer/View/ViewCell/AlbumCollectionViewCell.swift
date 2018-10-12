//
//  AlbumCollectionViewCell.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 10/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbAlbum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.primary
    }
    
    public func configure(album: Album) {
        imageView.image = album.image
        lbAlbum.text = album.title
    }
}
