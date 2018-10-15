//
//  MusicViewModel.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 12/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import AVKit

class MusicViewModel {
    
    private var player: AVPlayer?
    
    func audioPlayer(urlString: String) {
        guard let url = URL.init(string: urlString)
            else {
                return
        }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player!.play()
    }
}
