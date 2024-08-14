//
//  StockWidgetsEntryView.swift
//  StockWidgetsExtension
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import SwiftUI
import WidgetKit

struct StockWidgetsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
            if let symbol = entry.configuration.symbol {
                Text("Symbol: \(symbol)")
            }
        }
        .backdrop {
            Color.white
        }
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
