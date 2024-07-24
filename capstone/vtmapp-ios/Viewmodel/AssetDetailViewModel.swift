//
//  AssetDetailViewModel.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/24/24.
//
import SwiftUI
import AVFoundation

@MainActor
class AssetDetailViewModel: ObservableObject {
    @Published var asset: Asset?
    @Published var player: AVPlayer?
    @Published var downloadButtonTitle = "Download"
    @Published var isDownloaded = false
    @Published var showDownloadSheet = false
    @Binding var isAuthenticated: Bool

    let assetID: Int

    init(assetID: Int, isAuthenticated: Binding<Bool>) {
        self.assetID = assetID
        self._isAuthenticated = isAuthenticated
    }

    func fetchAssetDetail() async {
        let decoder = JSONDecoder()
        guard let url = URL(string: "\(API.baseURL)/api/assets/\(assetID)"),
              let token = KeychainHelper.shared.get("authToken") else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        let session = URLSession(configuration: configuration)

        do {
            let (data, _) = try await session.data(for: request)
            let asset = try decoder.decode(Asset.self, from: data)
            self.asset = asset
            if let file = asset.file, let url = URL(string: file.url) {
                self.player = AVPlayer(url: url)
                self.player?.play()
            }
            self.downloadButtonTitle = "Download \(asset.title)"
        } catch {
            print("Error decoding JSON \(error)")
        }
    }

    func downloadVideo() async {
        guard let urlString = asset?.file?.url, let url = URL(string: urlString) else {
            print("Error invalid URL")
            return
        }
        let session = URLSession.shared
        do {
            let (localURL, _) = try await session.download(from: url)
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let timestamp = Int(Date().timeIntervalSince1970)
            let uniqueFileName = "\(timestamp)_\(url.lastPathComponent)"
            let destinationURL = documentsDirectory.appendingPathComponent(uniqueFileName)

            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            try FileManager.default.copyItem(at: localURL, to: destinationURL)
            print("Video downloaded to \(destinationURL)")

            self.isDownloaded = true
            self.showDownloadSheet = true
            await dismissSheet()
        } catch {
            print("Error downloading or saving video: \(error)")
        }
    }

    func dismissSheet() async {
        try? await Task.sleep(nanoseconds: 1_600_000_000)
        self.showDownloadSheet = false
    }

    func signOut() {
        KeychainHelper.shared.delete("authToken")
        isAuthenticated = false
    }

    func toggleDownload() async {
        if !isDownloaded {
            await downloadVideo()
            withAnimation {
                isDownloaded = true
            }
        }
    }
}
