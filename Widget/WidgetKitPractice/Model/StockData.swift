//
//  StockData.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import Foundation

struct StockData: Codable, Identifiable {
    struct MetaData: Codable {
        let information: String
        let symbol: String
        let lastRefreshed: String
        let interval: String
        let outputSize: String
        let timeZone: String
        
        private enum CodingKeys: String, CodingKey {
            case information = "1. Information"
            case symbol = "2. Symbol"
            case lastRefreshed = "3. Last Refreshed"
            case interval = "4. Interval"
            case outputSize = "5. Output Size"
            case timeZone = "6. Time Zone"
        }
    }
    
    struct StockDataEntry: Codable {
        let open: String
        let high: String
        let low: String
        let close: String
        let volume: String
        
        enum CodingKeys: String, CodingKey {
            case open = "1. open"
            case high = "2. high"
            case low = "3. low"
            case close = "4. close"
            case volume = "5. volume"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5min = "Time Series (5min)"
    }
    
    var id = UUID()
    
    let metaData: MetaData
    let timeSeries5min: [String : StockDataEntry]
    
    var latestClose: String {
        timeSeries5min.first?.value.close ?? "NaN"
    }
    
    var latestCloseValues: [Double]  {
        let rawValues = timeSeries5min.values.compactMap { Double($0.close)! }

        let max = rawValues.max()!
        let min = rawValues.min()!
        
        return rawValues.map { ($0 - min * 0.95) / (max - min * 0.95) }
        
    }
    
    var url: URL {
        guard let url = URL(string: "stockapp://symbol/\(metaData.symbol)") else {
            fatalError("Failed to construct")
        }
        return url
    }
    
}
