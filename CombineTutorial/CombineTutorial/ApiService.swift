//
//  ApiService.swift
//  CombineTutorial
//
//  Created by Asaduzzaman Shuvro on 5/9/24.
//

import Foundation
import Combine

class ApiService {
    private var cancellable = Set<AnyCancellable>()
    @Published var sentence = ""
    
    func just42() -> AnyPublisher<Int, Never> {
        Just(42)
            .eraseToAnyPublisher()
    }
    
    func just100() -> AnyPublisher<Int, Never> {
        Just(100)
            .eraseToAnyPublisher()
    }
    
    func combineLatest() -> AnyPublisher<Int, Never> {
        just42().combineLatest(just100())
            .map { $0 + $1 }
            .eraseToAnyPublisher()
    }
    
    func assign() {
        just42()
            .receive(on: DispatchQueue.main)
            .map {
                "I received \($0)"
            }
            .assign(to: \.sentence, on: self)
            .store(in: &cancellable)
    }
    
    func subscribe() {
        just42().sink { number in
            print("I received \(number)")
        }
        .store(in: &cancellable)
    }
}

final class ViewModel: ObservableObject {
    @Published var nameFromTextField = ""
    
    func published() -> AnyPublisher<String, Never> {
        $nameFromTextField
            .map {
                "You entered \($0)"
            }
            .eraseToAnyPublisher()
    }
}
