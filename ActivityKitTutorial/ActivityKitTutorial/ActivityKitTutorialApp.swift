//
//  ActivityKitTutorialApp.swift
//  ActivityKitTutorial
//
//  Created by Asaduzzaman Shuvro on 15/8/24.
//

import SwiftUI

@main
struct ActivityKitTutorialApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
