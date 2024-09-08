//
//  CompacMapOperatorWithCombine.swift
//  CombineTutorial
//
//  Created by SHUVRO on 9/8/24.
//

import Foundation
import Combine

class CompacMapOperator {
    var cancellable: AnyCancellable!
    let dictionary: [Int : String] = [1 : "One", 2 : "Two", 3 : "Three", 5 : "Five"]
    let numbers = (0...5)
    
    init() {
       cancellable = numbers.publisher
            .compactMap { self.dictionary[$0] }
            .sink { value in
                print(value)
            }
    }
}
