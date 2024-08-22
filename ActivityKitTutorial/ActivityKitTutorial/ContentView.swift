//
//  ContentView.swift
//  ActivityKitTutorial
//
//  Created by Asaduzzaman Shuvro on 15/8/24.
//

import SwiftUI
import CoreData
import ActivityKit

struct ContentView: View  {
    
    @State private var isTrackingTime: Bool = false
    @State private var startTime: Date? = nil
    @State private var activity: Activity<TimeTrackingAttributes>? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if let startTime {
                    Text(startTime, style: .relative)
                }
                
                Button {
                    isTrackingTime.toggle()
                    if isTrackingTime {
                        // start the live activity
                        startTime = .now
                        let attributes = TimeTrackingAttributes()
                        let state = TimeTrackingAttributes.ContentState(startTime: .now)
                        if #available(iOS 16.2, *) {
                            let content = ActivityContent(state: state, staleDate: nil)
                            activity = try? Activity<TimeTrackingAttributes>.request(attributes: attributes, content: content, pushType: .token)
                        } else {
                            // Fallback on earlier versions
                        }
                        print(activity)
                    } else {
                        // stop live activity
                        guard let startTime else { return  }
                        let state = TimeTrackingAttributes.ContentState(startTime: startTime)
                        Task {
                            await activity?.end(using: state, dismissalPolicy: .immediate)
                        }
                        self.startTime = nil
                        
                    }
                } label: {
                    Text(isTrackingTime ? "STOP" : "START")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .background(
                            Circle()
                                .fill( isTrackingTime ? .red : .green)
                        )
                }
                .navigationTitle("Basic Time Tracker")
            }
        }
    }
}

#Preview {
    ContentView()
}
