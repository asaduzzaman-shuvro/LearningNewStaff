//
//  ContentView.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 11/8/24.
//

import SwiftUI
import CoreData

struct ContentView: View  {
    @ObservedObject private var model = ContentViewModel()
    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("Symbol", text: $model.symbol)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add", action: model.addStock)
                        .disabled(!model.symbolValid)
                }
                if !model.stockDatas.isEmpty {
                    ForEach(model.stockDatas) { stock in
                        HStack {
                            Text(stock.metaData.symbol)
                            Spacer()
                            
                            LineChart(values: stock.latestCloseValues)
                                .fill(
                                    LinearGradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)], startPoint: .top, endPoint: .bottom)
                                )
                                .frame(width: 150, height: 50)
                            
                            VStack(alignment: .leading, content: {
                                Text(stock.latestClose)
                                Text("Change")
                            })
                        }
                    }.onDelete(perform: model.delete(at:))
                }
            }
            .navigationTitle("My Stocks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
