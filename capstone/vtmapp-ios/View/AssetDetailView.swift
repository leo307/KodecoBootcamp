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
    @State private var downloadButtonTitle = "Download"
    @State private var isDownloaded = false

    var body: some View {
        VStack {
            if asset != nil {
                TabView {
                    VideoView(player: player)
                        .tabItem {
                            Label("Video", systemImage: "play.circle")
                        }
                    
                    AssetDetailsView(asset: asset)
                        .tabItem {
                            Label("Information", systemImage: "info.circle")
                        }
                }
                
                Button(action: downloadVideo) {
                    withAnimation {
                        if isDownloaded {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Downloaded")
                            }
                            .transition(.opacity)
                        } else {
                            HStack {
                                Image(systemName: "arrow.down.circle")
                                    .foregroundColor(.primary)
                                Text("Download")
                                    .foregroundColor(.primary)
                            }
                            .transition(.opacity)
                        }
                    }
                }
                .padding()
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            fetchAssetDetail()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: signOut) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.primary)
                        Text("Sign Out")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
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
                    self.downloadButtonTitle = "Download \(asset.title)"
                }
            } catch {
                print("Error decoding JSON \(error)")
                if let responseBody = String(data: data, encoding: .utf8) {
                    print("Error response \(responseBody)")
                }
            }
        }.resume()
    }

    func downloadVideo() {
        guard let urlString = asset?.file?.url, let url = URL(string: urlString) else {
            print("Error invalid URL")
            return
        }
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { localURL, response, error in
            guard let localURL = localURL else {
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                } else {
                    print("Error downloading")
                }
                return
            }
            do {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let timestamp = Int(Date().timeIntervalSince1970)
                let uniqueFileName = "\(timestamp)_\(url.lastPathComponent)"
                let destinationURL = documentsDirectory.appendingPathComponent(uniqueFileName)
                
                if FileManager.default.fileExists(atPath: destinationURL.path) {
                    try FileManager.default.removeItem(at: destinationURL)
                }
                try FileManager.default.copyItem(at: localURL, to: destinationURL)
                print("Video downloaded to \(destinationURL)")
                
                print(asset ?? "") // Debugging
                
                DispatchQueue.main.async {
                    self.isDownloaded = true
                }
            } catch {
                print("Error saving video \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func signOut() {
        KeychainHelper.shared.delete("authToken")
        isAuthenticated = false
    }
}
