//
//  MockURLProtocol.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/18/24.
//
import Foundation

class MockURLProtocol: URLProtocol {
    static var stubbedData: Data?
    static var stubbedResponse: URLResponse?
    static var stubbedError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.stubbedError {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = MockURLProtocol.stubbedResponse {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = MockURLProtocol.stubbedData {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
