//
//  AudioPlayerService.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 3/12/24.
//

import Foundation
import AVFoundation

protocol AudioPlayerService { /// And then I want to wrap this inside a protocol so that we can do dependency injection as well as unit tests to facilitate the unit test.
    func playSound()
}

final class defaultAudioPlayer: AudioPlayerService { /// And I think I can just do a final class over here so that we optimize the performance.
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
     
}
