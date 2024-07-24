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
            /* I understand this would be bad practice to do in a production environment, this is only included for testing purposes of this project */
        passwordField.tap()
        passwordField.typeText("test12345")
        signInButton.tap()
            
        let assetLink = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "assetLink_")).firstMatch
        XCTAssertTrue(assetLink.waitForExistence(timeout: 10), "The link loads within 10 seconds.")
        assetLink.tap()

        let videoPlayer = app.otherElements["videoPlayer"]
        XCTAssertTrue(videoPlayer.waitForExistence(timeout: 10), "Videoplayer")

        let shareButton = app.buttons["shareButton"]
        if shareButton.exists {
            XCTAssertTrue(shareButton.waitForExistence(timeout: 5), "Share button visible while video playing.")
        } else {
            let errorMessage = app.staticTexts["errorMessage"]
            XCTAssertTrue(errorMessage.waitForExistence(timeout: 5), "No watch URL ")
        }
        }

    }
}
