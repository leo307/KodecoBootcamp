//
//  vtmapp_iosUITests.swift
//  vtmapp-iosUITests
//
//  Created by Leo DelPrete on 7/24/24.
//
import XCTest

final class UITests: XCTestCase {

    func testLoginScreen() {
        let app = XCUIApplication()
        app.launch()
        let signOutButton = app.buttons["signOutButton"]

        if(signOutButton.exists){
            signOutButton.tap()
        } else {
            let signInButton = app.buttons["signInButton"]
            XCTAssertTrue(signInButton.exists)
        }
    }

    func testLoginAndNavigateToVideo() {
        let app = XCUIApplication()
        app.launch()
        let signOutButton = app.buttons["signOutButton"]

        if(signOutButton.exists){
            signOutButton.tap()
        } else {
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let signInButton = app.buttons["signInButton"]

        XCTAssertTrue(emailField.waitForExistence(timeout: 10), "Email field should exist")
        XCTAssertTrue(passwordField.waitForExistence(timeout: 10), "Password field should exist")
        XCTAssertTrue(signInButton.waitForExistence(timeout: 10), "Sign in button should exist")
        emailField.tap()
        emailField.typeText("leo@mobilelocker.com")
        passwordField.tap()
        passwordField.typeText("test12345")
        signInButton.tap()
            
        let assetLink = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "assetLink_")).firstMatch
        XCTAssertTrue(assetLink.waitForExistence(timeout: 10), "The asset link should appear within 10 seconds.")
        assetLink.tap()

        let videoPlayer = app.otherElements["videoPlayer"]
        XCTAssertTrue(videoPlayer.waitForExistence(timeout: 10), "The VideoPlayer should be visible when a player is provided.")

        let shareButton = app.buttons["shareButton"]
        if shareButton.exists {
            XCTAssertTrue(shareButton.waitForExistence(timeout: 5), "The Share button should be visible when a watchURL is provided.")
        } else {
            let errorMessage = app.staticTexts["errorMessage"]
            XCTAssertTrue(errorMessage.waitForExistence(timeout: 5), "The error message should be visible when no watchURL is provided.")
        }
        }

    }
}
