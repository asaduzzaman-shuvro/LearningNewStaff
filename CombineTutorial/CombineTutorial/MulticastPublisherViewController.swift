//
//  MulticastPublisherViewController.swift
//  CombineTutorial
//
//  Created by Asaduzzaman Shuvro on 18/10/24.
//

import UIKit
import Combine

class MulticastPublisherViewController: UIViewController {

    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var textView3: UITextView!

    
    private var anyCancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        simpleMulticast()
//        multicast()
        shareMulticast()
    }
    
    func valuePublisher() -> Publishers.Zip<Publishers.Sequence<[Int], Never>, Publishers.Autoconnect<Timer.TimerPublisher>> {
        let timerPublisher = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
        return Publishers.Zip([1, 2, 3, 4, 5, 6, 7, 8, 9].publisher, timerPublisher)
    }
    
    func simpleMulticast() {
        let zipPublisher = valuePublisher()
        
        let publisher = zipPublisher
            .print()
            .map { "\($0.0)"}
            .eraseToAnyPublisher()
        
            
        // create subscription
        publisher
            .map { "\(self.textView1.text ?? "")\n\($0)" }
            .assign(to: \.text, on: textView1)
            .store(in: &anyCancellables)
        
        // create subscription
        publisher
            .map { "\(self.textView2.text ?? "")\n\($0)" }
            .assign(to: \.text, on: textView2)
            .store(in: &anyCancellables)
        
    }
    
    let subject = PassthroughSubject<String, Never>()
    
    
    func multicast() {
        let zipPublisher = valuePublisher()
        
        let publisher = zipPublisher
            .map { "\($0.0)"}
            .print()
            .eraseToAnyPublisher()

        let multicast = publisher.multicast(subject: subject)
        
        
        // create 1st subscription
        multicast
            .map { "\(self.textView1.text ?? "")\n\($0)" }
            .assign(to: \.text, on: textView1)
            .store(in: &anyCancellables)
        
        // create 2nd subscription
        multicast
            .map { "\(self.textView2.text ?? "")\n\($0)" }
            .assign(to: \.text, on: textView2)
            .store(in: &anyCancellables)

        textView3.text = "\n\n\n\n\n"
        
        multicast.connect()
            .store(in: &anyCancellables)
        
        //create 3rd subscription
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            multicast
                .map { "\(self.textView3.text ?? "")\n\($0)" }
                .assign(to: \.text, on: self.textView3)
                .store(in: &self.anyCancellables)
        }
    }
    
    func shareMulticast() {
        let zipPublisher = valuePublisher()
        
        let publisher = zipPublisher
            .map { "\($0.0)"}
            .print()
            .eraseToAnyPublisher()
        
        let multicast = publisher.share()
        
        
        // create 1st subscription
        multicast
            .map { "\(self.textView1.text ?? "")\n\($0)" }
            .assign(to: \.text, on: textView1)
            .store(in: &anyCancellables)
        
        // create 2nd subscription
        multicast
            .map { "\(self.textView2.text ?? "")\n\($0)" }
            .assign(to: \.text, on: textView2)
            .store(in: &anyCancellables)
        
        textView3.text = "\n\n\n\n\n"
        
        
        //create 3rd subscription
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            multicast
                .map { "\(self.textView3.text ?? "")\n\($0)" }
                .assign(to: \.text, on: self.textView3)
                .store(in: &self.anyCancellables)
        }
    }
}
