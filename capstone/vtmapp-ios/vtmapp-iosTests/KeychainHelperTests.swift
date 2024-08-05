//
//  KeychainHelperTests.swift
//  vtmapp-iosTests
//
//  Created by Leo DelPrete on 7/18/24.
//
import XCTest
@testable import vtmapp_ios

class KeychainHelperTests: XCTestCase {
    
    let keychainHelper = KeychainHelper.shared
    let testKey = "testKey"
    let testValue = "testValue"
    
    override func setUp() {
        super.setUp()
        keychainHelper.delete(testKey)
    }
    
    func testSave() {
        keychainHelper.save(testValue, forKey: testKey)
        let retrievedValue = keychainHelper.get(testKey)
        XCTAssertEqual(retrievedValue, testValue, "The value retrieved from the keychain should match the value that was saved.")
    }
    
    func testGet() {
        keychainHelper.save(testValue, forKey: testKey)
        let retrievedValue = keychainHelper.get(testKey)
        XCTAssertEqual(retrievedValue, testValue, "The value retrieved from the keychain should match the value that was saved.")
    }
    
    func testDelete() {
        keychainHelper.save(testValue, forKey: testKey)
        keychainHelper.delete(testKey)
        let retrievedValue = keychainHelper.get(testKey)
        XCTAssertNil(retrievedValue, "The value should be nil after it has been deleted from the keychain.")
    }
    
    override func tearDown() {
        keychainHelper.delete(testKey)
        super.tearDown()
    }
}
