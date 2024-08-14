//
//  StockWidgets.swift
//  StockWidgets
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct StockWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
        .backdrop {
            Color.white
        }
    }
}

struct StockWidgets: Widget {
    let kind: String = "StockWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                StockWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                StockWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


struct StockWidgetsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StockWidgetsEntryView(entry: Provider.Entry(date: Date(), emoji: "😀"))
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
