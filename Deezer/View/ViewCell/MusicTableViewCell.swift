//
//  MusicTableViewCell.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 10/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbArtist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.primary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(music: Music) {
        lbName.text = music.title
        lbArtist.text = music.artist?.name
    }
}
