//
//  useminji_3App.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/04/24.
//

import SwiftUI
import SwiftData

@main
struct useminji_3App: App {
    
    var sharedModelContainer: ModelContainer = {
        let scheme = Schema([
            Project.self,
            Client.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: scheme, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: scheme, configurations: modelConfiguration)
        } catch {
            fatalError("DEBUG: Could not create data \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}
