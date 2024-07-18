//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo Delprete on 7/8/24.
//
import SwiftUI

struct AssetListView: View {
    @State private var assets: [Asset] = []
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationView {
            List(assets) { asset in
                NavigationLink(destination: AssetDetailView(assetID: asset.id, isAuthenticated: $isAuthenticated)) {
                    VStack(alignment: .leading) {
                        if let thumbnail = asset.thumbnail, let url = URL(string: thumbnail.url) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Text(asset.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical)
                }
            }
            .onAppear {
                fetchAssets()
            }
            .navigationTitle("Assets")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: signOut) {
                        Text("SIGN OUT")
                    }
                }
            }
        
        }
    }

    func fetchAssets() {
        guard let url = URL(string: "\(API.baseURL)/api/current-user/assets"),
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
                let json = try JSONDecoder().decode([Asset].self, from: data)
                DispatchQueue.main.async {
                    assets = json
                }
            } catch {
                print("Error decoding JSON: \(error)")
                print("DEBUGGING CHECKPOINT")
                if let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")
                }
            }
        }.resume()
    }

    func signOut() {
        KeychainHelper.shared.delete("authToken")
        isAuthenticated = false
    }
}
