//
//  LoginUnitTests.swift
//  vtmapp-iosTests
//
//  Created by Leo DelPrete on 7/18/24.
//
import XCTest
@testable import vtmapp_ios

class LoginTests: XCTestCase {
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        viewModel = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let encoder = JSONEncoder()
        let mockResponse = LoginResponse(two_factor: false, token: "mock_token")
        let jsonData = try! encoder.encode(mockResponse)
        
        MockURLProtocol.stubbedData = jsonData
        MockURLProtocol.stubbedResponse = HTTPURLResponse(url: URL(string: "\(API.baseURL)/login")!,
                                                          statusCode: 200,
                                                          httpVersion: nil,
                                                          headerFields: nil)
        MockURLProtocol.stubbedError = nil
        
        let expectation = self.expectation(description: "Login succeeded")
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.login()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isAuthenticated)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginFailureInvalidCredentials() {
        MockURLProtocol.stubbedData = nil
        MockURLProtocol.stubbedResponse = HTTPURLResponse(url: URL(string: "\(API.baseURL)/login")!,
                                                          statusCode: 401,
                                                          httpVersion: nil,
                                                          headerFields: nil)
        MockURLProtocol.stubbedError = nil
        
        let expectation = self.expectation(description: "Login failed with invalid credentials")
        viewModel.email = "test@example.com"
        viewModel.password = "wrongpassword"
        viewModel.login()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isAuthenticated)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginNetworkError() {
        MockURLProtocol.stubbedData = nil
        MockURLProtocol.stubbedResponse = nil
        MockURLProtocol.stubbedError = NSError(domain: "NetworkError", code: 0, userInfo: nil)
        
        let expectation = self.expectation(description: "Login failed with network error")
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.login()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isAuthenticated)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
import SwiftUI
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    
    func login() {
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
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = "Error with network. Please try again."
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                DispatchQueue.main.async {
                    self.errorMessage = "Error Invalid email or password."
                }
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                KeychainHelper.shared.save(loginResponse.token, forKey: "authToken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            } catch {
                print("Error \(error)")
                if let responseBody = String(data: data, encoding: .utf8) {
                    print("Error response \(responseBody)")
                }
                DispatchQueue.main.async {
                    self.errorMessage = "Error"
                }
            }
        }.resume()
    }
}



