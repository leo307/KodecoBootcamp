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
                    VStack(alignment: .leading, spacing: 8) {
                        if let thumbnail = asset.thumbnail, let url = URL(string: thumbnail.url) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 120)
                            .padding(.bottom, 8)
                        }
                        
                        Text(asset.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 12)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .onAppear {
                fetchAssets()
            }
            .navigationTitle("Assets")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: signOut) {
                        Image(systemName: "person.fill")
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                        Text("Sign Out")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color(.systemGroupedBackground))
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
            guard let data = data, error == nil else {
                print("Error fetching assets: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let json = try decoder.decode([Asset].self, from: data)
                DispatchQueue.main.async {
                    assets = json
                }
            } catch {
                print("Error decoding JSON: \(error)")
                print("DEBUGGING CHECKPOINT")
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
