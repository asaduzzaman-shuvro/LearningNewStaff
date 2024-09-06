//
//  InputView.swift
//  CombineTutorial
//
//  Created by Asaduzzaman Shuvro on 5/9/24.
//

import SwiftUI
import Combine

class validator {
    @Published var name = ""
    @Published var task: [MWTask] = []
    
    @Published var workoutStatus: WorkoutStatus = .valid
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isWorkoutValid
            .receive(on: RunLoop.main)
            .assign(to: \.workoutStatus, on: self)
            .store(in: &cancellables)
    }
    
    enum WorkoutStatus: String {
        case  notEnoughTasks = "You can't create workout without exercises"
        case titleNotFound = "Workout Title has to be more that 5 character"
        case valid = "Your input is valid"
    }
    
    private var isTitleValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { $0.count > 5 }
            .eraseToAnyPublisher()
    }
    
    private var isTasksNotEmptyPublisher: AnyPublisher<Bool, Never> {
        $task
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { $0.count > 0}
            .eraseToAnyPublisher()
    }
    
    private var isWorkoutValid: AnyPublisher<WorkoutStatus, Never> {
        Publishers.CombineLatest(isTitleValidPublisher, isTasksNotEmptyPublisher)
            .map {
                if !$0 { return .titleNotFound }
                if !$1 { return .notEnoughTasks }
                return .valid
            }
            .eraseToAnyPublisher()
    }
}


struct MWTask {}
