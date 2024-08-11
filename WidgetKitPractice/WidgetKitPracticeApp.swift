//
//  WidgetKitPracticeApp.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 11/8/24.
//

import SwiftUI

@main
struct WidgetKitPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
