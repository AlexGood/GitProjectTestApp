//
//  TestProjectApp.swift
//  TestProject
//
//  Created by Alexandr Kudlak on 29.02.2024.
//

import SwiftUI

@main
struct TestProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        Connectivity.shared.startMonitoring()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
