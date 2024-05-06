//
//  CounterFeature.swift
//  ComposableArchitecturePoc
//
//  Created by Caio Beraldi Ribeiro on 02/05/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var fact: String?
        var divided = 0.0
        var isLoading = false
        var isTimerRunning = false
    }
  
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case divideByFourButtonTapped
        case toggleTimerButtonTapped
        case timerTick
    }
  
    enum CancelID { case timer }
    
    @Dependency(\.numberFact) var numberFact
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
        
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run { [count = state.count] send in
                    try await send(.factResponse(self.numberFact.fetch(count)))
                }
        
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
        
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            
            case .divideByFourButtonTapped:
                state.divided = Double(state.count) / 3
                return .none
                
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: "Bruh")
                } else {
                    return .cancel(id: "Bruh")
                }
            }
        }
    }
}
