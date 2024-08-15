//
//  ContentViewModel.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import Intents

final class ContentViewModel: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var stockDatas: [StockData] = []
    @Published var symbol = ""
    @Published var stockEntities: [StockEntity] = []
    @Published var symbolValid: Bool = false
    
    init() {
        loadFromCoreData()
        loadSymbols()
        validateSymbolFiled()
    }
    
    func validateSymbolFiled() {
        $symbol.sink { [unowned self] newValue in
            self.symbolValid = !newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        .store(in: &cancellables)
    }
    
    func loadFromCoreData() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.symbol = symbol
        do {
           try context.save()
        } catch {
            print(error)
        }
        stockEntities.append(newStock)
        getStockData(for: symbol)
        symbol = ""
    }
    
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        stockDatas.remove(at: index)
        let stockToRemove = stockEntities.remove(at: index)
        context.delete(stockToRemove)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func loadSymbols() {
        stockDatas = []
        stockEntities.forEach { entity in
            getStockData(for: entity.symbol ?? "")
        }
    }
    
    func getStockData(for symbol: String) {
        
        if let fileURL = Bundle.main.url(forResource: "StockJSON", withExtension: "json") {
            let publisher = MainBundlePublisher(fileURL: fileURL)
            publisher
                .decode(type: StockData.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { [unowned self] data in
                    self.stockDatas.append(data)
                }
                .store(in: &cancellables)
        } else {
            print("Couldn't find the url")
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
    
    func doneIntent() {
        let intent = ConfigurationIntent()
        intent.customSymbol = CustomSymbol(identifier: "AAPL", display: "Apple Inc.")
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.identifier = "AAPL-interation"
        interaction.donate { error in
            if let error = error {
                print(error)
            }
        }
        
        INInteraction.delete(with: "AAPL-interation") { error in
            if let error = error {
                print(error)
            }
        }
    }
}





