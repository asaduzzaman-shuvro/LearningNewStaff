//
//  Persistence.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 11/8/24.
//

import CoreData
import BackgroundTasks

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.shuvro.WidgetKitPractice.refresh", using: nil) { task in
            print(task)
        }

        let request = BGAppRefreshTaskRequest(identifier: "com.shuvro.WidgetKitPractice.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 30) // 15 minutes from now
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch let error {
            print("Failed to schedule app refresh: \(error)")
        }
        
        container = NSPersistentContainer(name: "WidgetKitPractice")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
