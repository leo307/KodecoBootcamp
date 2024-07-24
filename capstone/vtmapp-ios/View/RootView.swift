//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/8/24.
//
import SwiftUI

struct RootView: View {
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        ZStack {
            if isAuthenticated {
                AssetListView(isAuthenticated: $isAuthenticated)
            } else {
                LoginView(isAuthenticated: $isAuthenticated)
            }
        }
        .onAppear {
            checkAuthentication()
        }
    }
    
    func checkAuthentication() {
        if let _ = KeychainHelper.shared.get("authToken") {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
}
