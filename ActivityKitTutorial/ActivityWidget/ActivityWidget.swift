//
//  ActivityWidget.swift
//  ActivityWidget
//
//  Created by Asaduzzaman Shuvro on 15/8/24.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct ActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeTrackingAttributes.self) { liveActivityContext in
            TimeTrackingWidgetView(context: liveActivityContext)
        } dynamicIsland: { dynamicIslandContext in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading, priority: 1) {
                    Text("Main")
                }
            } compactLeading: {
                Text("CL")
            } compactTrailing: {
                Text("CT")
            } minimal: {
                Text("M")
            }
        }
    }
}


struct TimeTrackingWidgetView: View {
    let context: ActivityViewContext<TimeTrackingAttributes>
    
    var body: some View {
        Text(context.state.startTime, style: .relative)
    }
}
