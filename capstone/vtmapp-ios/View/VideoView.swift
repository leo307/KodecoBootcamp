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
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if let player = player {
                        VideoPlayer(player: player)
                            .aspectRatio(16/9, contentMode: .fit)
                            .frame(width: min(geometry.size.width * 0.9, 800), height: min(geometry.size.height * 0.9, 450))
                            .onAppear {
                                player.play()
                            }
                            .onDisappear {
                                player.pause()
                            }
                    } else {
                        ProgressView("Loading asset video please be patient.")
                            .frame(width: min(geometry.size.width * 0.9, 800), height: min(geometry.size.height * 0.9, 450))
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
