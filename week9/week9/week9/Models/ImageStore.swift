//
//  ImageStore.swift
//  week9
//
//  Created by Leo DelPrete on 6/16/24.
//

import Foundation

class ImageStore: ObservableObject {
    @Published var images: [PexelImage] = []
    @Published var downloadedPexelURL: URL?
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "PexelsInfo", ofType: "plist") else {
                fatalError("Error couldn't find file 'PexelsInfo.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Error couldn't find key 'API_KEY' in 'PexelsInfo.plist'.")
            }
            if (value.starts(with: "_")) {
                fatalError("Error register for a pexels account and get an API key at https://www.pexels.com/api/new/")
            }
            return value
        }
    }
    
    func fetchImages(query: String) async {
        let decoder = JSONDecoder()
        let urlString = "https://api.pexels.com/v1/search?query=\(query)&per_page=10"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try decoder.decode(PexelsResponse.self, from: data)
            DispatchQueue.main.async {
                self.images = result.photos
            }
        } catch {
            print("Error fetching images \(error)")
        }
    }
    
    func downloadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { localUrl, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            guard let localUrl = localUrl else {
                print("Error: No local URL returned.")
                return
            }
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectory.appendingPathComponent(localUrl.lastPathComponent)
            
            do {
                try FileManager.default.moveItem(at: localUrl, to: destinationUrl)
                DispatchQueue.main.async {
                    self.downloadedPexelURL = destinationUrl
                }
                print("Successfully downloaded image")
            } catch {
                print("Error moving downloaded file: \(error)")
            }
        }
        
        task.resume()
    }
}
