//
//  VideoView.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/18/24.
//

import SwiftUI
import AVKit

struct VideoView: View {
    let player: AVPlayer?
    
    var body: some View {
        VStack {
            if let player = player {
                VideoPlayer(player: player)
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        player.play()
                    }
                    .onDisappear {
                        player.pause()
                    }
            } else {
                ProgressView("Loading video...")
            }
        }
    }
}
