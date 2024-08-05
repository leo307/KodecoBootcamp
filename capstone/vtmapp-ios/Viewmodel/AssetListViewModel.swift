//
//  AssetListViewModel.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/24/24.
//
import SwiftUI
import Combine

@MainActor
class AssetListViewModel: ObservableObject {
    @Published var assets: [Asset] = []
    @Published var isAuthenticated: Bool = false

    func fetchAssets() async {
        let decoder = JSONDecoder()
        guard let url = URL(string: "\(API.baseURL)/api/current-user/assets"),
              let token = KeychainHelper.shared.get("authToken") else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        let session = URLSession(configuration: configuration)

        do {
            let (data, _) = try await session.data(for: request)
            let json = try decoder.decode([Asset].self, from: data)
            self.assets = json
        } catch {
            print("Error \(error)")
        }
    }

    func signOut() {
        KeychainHelper.shared.delete("authToken")
        self.isAuthenticated = false
    }
}
