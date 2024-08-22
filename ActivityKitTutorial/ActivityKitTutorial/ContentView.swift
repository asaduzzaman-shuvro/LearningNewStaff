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
                        if ActivityAuthorizationInfo().areActivitiesEnabled {
                            let attributes = TimeTrackingAttributes()
                            let initialState = TimeTrackingAttributes.State(startTime: Date())
                            do {
                                let activity = try Activity.request(attributes: attributes, content: .init(state: initialState, staleDate: nil), pushType: .token)
                                self.activity = activity
                            } catch let error {
                                print(error.localizedDescription)
                            }
                        } else {
                            print("Activity inn't enabled")
                        }
                       
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
            .onAppear(perform: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    } else {
                        print("Permission for push notifications denied.")
                    }
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
