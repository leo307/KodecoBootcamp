//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/8/24.
//
import SwiftUI
import SwiftData

@main
struct VTMApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            sleep(2)
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Error : \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
