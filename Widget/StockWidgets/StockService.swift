//
//  StockService.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import Foundation
import Combine

struct StockService {
    func getStockData(for symbol: String) -> AnyPublisher<StockData, Error> {
        
        if let fileURL = Bundle.main.url(forResource: "StockJSON", withExtension: "json") {
            let publisher = MainBundlePublisher(fileURL: fileURL)
            return publisher
                .decode(type: StockData.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                
        } else {
            return Fail(error: URLError(.fileDoesNotExist)).eraseToAnyPublisher()
        }
        
        //        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=\(APIKEY)")!
        //
        //        URLSession.shared
        //            .dataTaskPublisher(for: url)
        //            .tryMap { element -> Data in
        //                guard let httpResponse = element.response as? HTTPURLResponse,
        //                      httpResponse.statusCode == 200 else {
        //                    throw URLError(.badServerResponse)
        //                }
        //                return element.data
        //            }
        //            .decode(type: StockData.self, decoder: JSONDecoder())
        //            .receive(on: DispatchQueue.main)
        //            .sink { completion in
        //                switch completion {
        //                case .failure(let error):
        //                    print(error)
        //                    return
        //                case .finished:
        //                    return
        //                }
        //            } receiveValue: { [unowned self] stockData in
        //                self.stockDatas.append(stockData)
        //            }
        //            .store(in: &cancellables)
    }
}
