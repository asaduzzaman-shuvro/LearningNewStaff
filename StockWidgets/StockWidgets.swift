//
//  StockWidgets.swift
//  StockWidgets
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import WidgetKit
import SwiftUI

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



struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct StockWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
            if let symbol = entry.configuration.symbol {
                Text("Emoji:")
                Text(symbol)
            }
        }
        .backdrop {
            Color.white
        }
    }
}

struct StockWidgets: Widget {
    let kind: String = "StockWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), content: { entry in
            StockWidgetsEntryView(entry: entry)
        })
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


struct StockWidgetsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StockWidgetsEntryView(
            entry: Provider.Entry(
                date: Date(),
                configuration: ConfigurationIntent()
            )
        )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


extension View {
    func backdrop(@ViewBuilder _ content: () -> some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return background(content())
                .containerBackground(for: .widget, content: content)
        } else {
            return background(content())
        }
    }
}
