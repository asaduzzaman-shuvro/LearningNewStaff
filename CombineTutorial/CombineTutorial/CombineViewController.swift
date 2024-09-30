//
//  CombineViewController.swift
//  CombineTutorial
//
//  Created by Asaduzzaman Shuvro on 6/9/24.
//

import UIKit
import Combine
import SwiftUI

class CombineViewController: UIViewController {
    private var currentValue = 0

    private let label = UILabel()
    private var anyCancellable = Set<AnyCancellable>()
    private let publisher = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didPressOnButton(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        label.text = "The value is: \(currentValue)"
        label.frame = CGRect(x: 0, y: 200, width: 200, height: 100)
        view.addSubview(label)
        
        bind()
    }
    
    private func bind() {
        publisher
            .map { "The value is:  \($0)" }
            .assign(to: \.text!, on: label)
            .store(in: &anyCancellable)
    }
    
    @objc private func didPressOnButton(sender: Any) {
        currentValue += 1
        publisher.send("\(currentValue)")
    }
}

struct CombineView: UIViewControllerRepresentable {
    typealias UIViewControllerType = FlatMapCombineOperatorViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        return FlatMapCombineOperatorViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
