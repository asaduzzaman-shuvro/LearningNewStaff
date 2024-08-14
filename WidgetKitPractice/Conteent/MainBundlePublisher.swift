//
//  MainBundlePublisher.swift
//  WidgetKitPractice
//
//  Created by Asaduzzaman Shuvro on 14/8/24.
//

import Foundation
import Combine

struct MainBundlePublisher: Publisher {
    typealias Output = Data
    typealias Failure = Error
    
    let fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, any Failure == S.Failure, Data == S.Input {
        let subscription = FileSubscription(subscriber: subscriber, fileURL: fileURL)
        subscriber.receive(subscription: subscription)
    }
    
    private class FileSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
        private var subscriber: S?
        private let  url: URL
        
        init(subscriber: S, fileURL: URL) {
            self.subscriber = subscriber
            self.url = fileURL
            readFile()
        }

        
        func request(_ demand: Subscribers.Demand) {
            
        }
        
        func cancel() {
            subscriber = nil
        }
        
        private func readFile() {
            do {
                let data = try Data(contentsOf: url)
                _ = subscriber?.receive(data)
                subscriber?.receive(completion: .finished)
            } catch {
                subscriber?.receive(completion: .failure(error))
            }
        }
    }
    
}
