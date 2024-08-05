//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/8/24.
//
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack {
            Image("LoginScreen")
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .accessibilityIdentifier("emailField")
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .accessibilityIdentifier("passwordField")
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .accessibilityIdentifier("errorMessage")
            }
            Button(action: {
                Task {
                    await viewModel.login()
                    isAuthenticated = viewModel.isAuthenticated
                }
            }) {
                Text("SIGN IN")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }
            .padding(.top, 20)
            .accessibilityIdentifier("signInButton")
        }
        .padding()
    }
}
