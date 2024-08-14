//
//  StockWidgetsEntryView.swift
//  StockWidgetsExtension
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import SwiftUI
import WidgetKit

struct StockWidgetsEntryView : View {
    @Environment(\.widgetFamily) var family
    
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            Text("Small widget")
                .backdrop {
                    Color.white
                }
        case .systemMedium:
            VStack {
                Text(entry.configuration.symbol ?? "No symbol found")
                Text(entry.configuration.customSymbol?.identifier ?? "No custom symbol selected")
                if let latestCloseValues = entry.stockData?.latestCloseValues {
                    LineChart(values: latestCloseValues)
                        .fill(
                            LinearGradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 150, height: 50)
                } else {
                    Text("No chart available at the moment")
                }
            }
            .widgetURL(entry.stockData?.url)
            .backdrop {
                Color.white
            }
        default:
            Text("Not implemented yet")
                .backdrop {
                    Color.white
                }
        }
    }
}
struct StockWidgetsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StockWidgetsEntryView(
            entry: Provider.Entry(
                date: Date(),
                configuration: ConfigurationIntent(), stockData: nil
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
