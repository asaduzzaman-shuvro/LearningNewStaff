//
//  StockWidgets.swift
//  StockWidgets
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import WidgetKit
import SwiftUI

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

