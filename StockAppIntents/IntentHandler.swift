//
//  IntentHandler.swift
//  StockAppIntents
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    func resolveSymbol(for intent: ConfigurationIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
    }
    
    func provideCustomSymbolOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<CustomSymbol>?, (any Error)?) -> Void) {
        let symbols: [CustomSymbol] = [
            CustomSymbol(identifier: "AAPL", display: "Apple Inc."),
            CustomSymbol(identifier: "GOOGL", display: "Alphabet Inc."),
            CustomSymbol(identifier: "MSFT", display: "Microsoft Corporation"),
            CustomSymbol(identifier: "AMZN", display: "Amazon.com Inc."),
            CustomSymbol(identifier: "TSLA", display: "Tesla Inc.")
        ]
        
        let collection = INObjectCollection(items: symbols)
        completion(collection, nil)
    }
}
