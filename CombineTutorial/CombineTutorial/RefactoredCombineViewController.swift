//
//  RefactoredCombineViewController.swift
//  CombineTutorial
//
//  Created by SHUVRO on 9/8/24.
//

import UIKit
import Combine

class RefactoredCombineViewController: UIViewController {

    private let label = UILabel()
    private var anyCancellable = Set<AnyCancellable>()
    private let publisher = PassthroughSubject<String, Never>()
    private let counter = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didPressOnButton(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        label.text = counter.value
        label.frame = CGRect(x: 0, y: 200, width: 200, height: 100)
        view.addSubview(label)
        
        bind()
        
        let _ = CompacMapOperator()

    }
    
    private func bind() {
        counter.$value
            .assign(to: \.text!, on: label)
            .store(in: &anyCancellable)
//        publisher
//            .map { "The value is:  \($0)" }
//            .assign(to: \.text!, on: label)
//            .store(in: &anyCancellable)
    }
    
    @objc private func didPressOnButton(sender: Any) {
        counter.increment()
    }
}


class Counter {
    @Published private (set) var value: String = "The value is 0"
    private var current = 0
    
    func increment() {
        current += 1
        value = "The value is \(current)"
    }
}
