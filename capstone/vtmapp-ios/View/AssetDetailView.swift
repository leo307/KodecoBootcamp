//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo Delprete on 7/8/24.
//
import SwiftUI
import AVKit

struct AssetDetailView: View {
    let assetID: Int
    @State private var asset: Asset?
    @State private var player: AVPlayer?
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack {
            if let asset = asset {
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
                Text(asset.title)
                    .font(.title)
                    .padding()
                Text(asset.description ?? "")
                    .padding()
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            fetchAssetDetail()
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: signOut) {
                    Text("SIGN O")
                
                }
            }
        }
    }

    func fetchAssetDetail() {
        let decoder = JSONDecoder()
        guard let url = URL(string: "\(API.baseURL)/api/assets/\(assetID)"),
              let token = KeychainHelper.shared.get("authToken") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let asset = try decoder.decode(Asset.self, from: data)
                DispatchQueue.main.async {
                    self.asset = asset
                    if let file = asset.file, let url = URL(string: file.url) {
                        self.player = AVPlayer(url: url)
                        self.player?.play()
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
                if let responseBody = String(data: data, encoding: .utf8) {
                    print("Error response \(responseBody)")
                }
            }
        }.resume()
    }

    func signOut() {
        KeychainHelper.shared.delete("authToken")
        isAuthenticated = false
    }
}
