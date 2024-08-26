//
//  AppIntents.swift
//  InteractiveButtonInWidget
//
//  Created by Asaduzzaman Shuvro on 26/8/24.
//

import AppIntents

let appGroupIdentifier = "group.interactivebuttonwidget"
let userDefaultCountKey = "count"

struct IncreaseCountIntent: AppIntent {
    static var title: LocalizedStringResource = "Increase Count"
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: appGroupIdentifier) {
            let count = store.integer(forKey: userDefaultCountKey)
            store.setValue(count + 1, forKey: userDefaultCountKey)
            return .result()
        }
        return .result()
    }
}


struct SetCountIntent: AppIntent {
    static var title: LocalizedStringResource = "Set count"
    
    @Parameter(title: "Value")
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    init() {
        self.value = -1
    }
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: appGroupIdentifier) {
            store.setValue(value, forKey: userDefaultCountKey)
            return .result()
        }
        return .result()
    }
}
