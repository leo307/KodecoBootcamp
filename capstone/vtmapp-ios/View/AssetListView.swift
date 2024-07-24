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
        NavigationStack {
            List(assets) { asset in
                NavigationLink(destination: AssetDetailView(assetID: asset.id, isAuthenticated: $isAuthenticated)) {
                    HStack {
                        if let thumbnail = asset.thumbnail, let url = URL(string: thumbnail.url) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 75)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 75)
                            }
                        } else {
                            Color.gray
                                .frame(width: 100, height: 75)
                        }

                        VStack(alignment: .leading) {
                            Text(asset.title)
                                .font(.headline)
                                .lineLimit(1)
                            Text("ID: \(asset.id)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
            }
            .onAppear {
                fetchAssets()
            }
            .navigationTitle("Assets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: signOut) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Sign Out")
                        }
                    }
                }
            }
        }
    }

    func fetchAssets() {
        let decoder = JSONDecoder()
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
                let json = try decoder.decode([Asset].self, from: data)
                DispatchQueue.main.async {
                    assets = json
                }
            } catch {
                print("Error \(error)")
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
