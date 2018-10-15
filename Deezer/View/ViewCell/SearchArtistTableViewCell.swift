//
//  SearchArtistTableViewCell.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 13/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class SearchArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(artist: Artist) {
        lbName.text = artist.name
    }
}
