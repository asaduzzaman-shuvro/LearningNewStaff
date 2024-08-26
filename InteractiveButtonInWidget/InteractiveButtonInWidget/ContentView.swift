//
//  ContentView.swift
//  InteractiveButtonInWidget
//
//  Created by Asaduzzaman Shuvro on 26/8/24.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage(userDefaultCountKey) var count = 0
    
    var body: some View {
        VStack {
            Button("\(count) +") {
                count += 1
                WidgetCenter.shared.reloadAllTimelines()
            }
            
            Button("Set to 42", intent: SetCountIntent(value: 42))
        }
        .buttonBorderShape(.roundedRectangle)
    }
}

#Preview {
    ContentView()
}
