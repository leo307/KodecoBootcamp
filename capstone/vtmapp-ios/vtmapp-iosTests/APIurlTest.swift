//
//  APIurlTest.swift
//  vtmapp-iosTests
//
//  Created by Leo DelPrete on 7/18/24.
//
import XCTest
@testable import vtmapp_ios

class APIConfigTests: XCTestCase {

    func testBaseURL() {
        let expectedURL = "https://app.vtmapp.com"
        let actualURL = API.baseURL
        
        XCTAssertEqual(actualURL, expectedURL, "The baseURL should be \(expectedURL).")
    }
}
