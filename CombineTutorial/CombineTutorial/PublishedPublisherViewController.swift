//
//  PublishedPublisherViewController.swift
//  CombineTutorial
//
//  Created by Asaduzzaman Shuvro on 23/10/24.
//

import UIKit
import Combine

class PublishedPublisherViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var model: SomeModel = .init()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        model.$state
            .map { "\($0)" }
            .assign(to: \.text, on: textLabel)
            .store(in: &cancellables)
    }
    
    @IBAction func didPressOnIncrementButton(_ sender: Any) {
        model.state += 1
    }
}

class SomeModel {
    @Published var state: Int = 0
}
