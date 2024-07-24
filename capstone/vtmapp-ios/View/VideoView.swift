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
    let asset: Asset?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if let player = player {
                    VStack {
                        VideoPlayer(player: player)
                            .aspectRatio(16/9, contentMode: .fit)
                            .frame(width: min(geometry.size.width * 0.9, 800), height: min(geometry.size.height * 0.6, 450))
                            .onAppear {
                                player.play()
                            }
                            .onDisappear {
                                player.pause()
                            }
                            .accessibilityIdentifier("videoPlayer")

                        if let watchURL = asset?.watchURL {
                            ShareLink(item: watchURL) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 20))
                                    Text("Share")
                                        .font(.system(size: 18))
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .padding(.top, 10)
                            .accessibilityIdentifier("shareButton")
                        } else {
                            Text("Share link could not be loaded")
                                .foregroundColor(.red)
                                .padding(.top, 10)
                                .accessibilityIdentifier("errorMessage")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ProgressView("Loading asset video please be patient.")
                        .frame(width: min(geometry.size.width * 0.9, 800), height: min(geometry.size.height * 0.6, 450))
                        .accessibilityIdentifier("loadingIndicator")
                }
                
                Spacer()
            }
            .padding()
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
