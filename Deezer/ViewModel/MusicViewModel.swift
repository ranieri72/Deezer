//
//  MusicViewModel.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 12/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import AVFoundation

class MusicViewModel {
    
    private var player: AVAudioPlayer?
    
    func audioPlayer(urlString: String) {
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(string: urlString)!)
            player?.prepareToPlay()
            player?.numberOfLoops = 2
            
            do {
                let audioSession = AVAudioSession.sharedInstance()
                if #available(iOS 10.0, *) {
                    try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                    play()
                }
            } catch { }
        } catch { }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        if player?.isPlaying ?? false {
            player?.pause()
        }
    }
    
    func stop(){
        if player?.isPlaying ?? false {
            player?.stop()
        }
    }
}
