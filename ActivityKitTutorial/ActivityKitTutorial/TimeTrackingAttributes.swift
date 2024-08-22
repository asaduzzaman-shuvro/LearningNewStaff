//
//  TimeTrackingAttributes.swift
//  ActivityKitTutorial
//
//  Created by Asaduzzaman Shuvro on 15/8/24.
//

import ActivityKit
import Foundation

public struct TimeTrackingAttributes: ActivityAttributes {
    public typealias ContentState = State
    
    public struct State: Codable, Hashable {
        var startTime: Date
        
    }
}
