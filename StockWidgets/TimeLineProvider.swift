//
//  TimeLineProvider.swift
//  StockWidgetsExtension
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import WidgetKit
import Intents

struct Provider: IntentTimelineProvider {
    typealias Entry = SimpleEntry
    typealias Intent = ConfigurationIntent
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        
        var entries = [SimpleEntry]()
        let currentDate = Date()
        
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            entries.append(SimpleEntry(date: entryDate, configuration: configuration))
        }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}
