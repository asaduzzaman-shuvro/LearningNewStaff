//
//  InteractiveButtonInWidgetApp.swift
//  InteractiveButtonInWidget
//
//  Created by Asaduzzaman Shuvro on 26/8/24.
//

import SwiftUI

@main
struct InteractiveButtonInWidgetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .defaultAppStorage(UserDefaults(suiteName: appGroupIdentifier)!)
        }
    }
}
