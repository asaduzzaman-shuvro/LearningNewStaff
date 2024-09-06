//
//  CombineTutorialApp.swift
//  CombineTutorial
//
//  Created by Asaduzzaman Shuvro on 5/9/24.
//

import SwiftUI


@main
struct CombineTutorialApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}



