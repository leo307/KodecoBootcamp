//
//  LoginViewModel.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/24/24.
//
import SwiftUI
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isAuthenticated = false

    func login() async {
        let decoder = JSONDecoder()
        guard let url = URL(string: "\(API.baseURL)/login") else { return }
        errorMessage = nil
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let body: [String: String] = [
            "email": email,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        let session = URLSession(configuration: configuration)

        do {
            let (data, response) = try await session.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                self.errorMessage = "Error with credentials."
                return
            }

            let loginResponse = try decoder.decode(LoginResponse.self, from: data)
            KeychainHelper.shared.save(loginResponse.token, forKey: "authToken")
            self.isAuthenticated = true
        } catch {
            print("Error: \(error)")
            self.errorMessage = "Error with either credentials or network."
        }
    }

    struct LoginResponse: Codable {
        let two_factor: Bool
        let token: String
    }
}
