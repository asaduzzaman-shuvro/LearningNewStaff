//
//  TimeLineProvider.swift
//  StockWidgetsExtension
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import WidgetKit
import Intents
import Combine

class Provider: IntentTimelineProvider {
    private var anyCancellable: Set<AnyCancellable> = []
    
    typealias Entry = SimpleEntry
    typealias Intent = ConfigurationIntent
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        createTimeLineEntry(date: Date(), configuration: configuration, completion: completion)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
       createTimeLine(date: Date(), configuration: configuration, completion: completion)
    }
    
    private func createTimeLineEntry(date: Date, configuration: ConfigurationIntent, completion: @escaping (SimpleEntry) -> Void) {
        
        StockService()
            .getStockData(for: configuration.symbol ?? "IBM")
            .sink { _ in
                
            } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuration, stockData: stockData)
                completion(entry)
            }
            .store(in: &anyCancellable)

    }
    
    private func createTimeLine(date: Date, configuration: ConfigurationIntent, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        
        StockService()
            .getStockData(for: configuration.symbol ?? "IBM")
            .sink { _ in
                
            } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuration, stockData: stockData)
                completion(Timeline(entries: [entry], policy: .never))
            }
            .store(in: &anyCancellable)
    }
}
