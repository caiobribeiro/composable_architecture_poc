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
    struct State {
        var counter = 0
        var divided = 0.0
    }

    enum Action {
        case decrement
        case increment
        case divide
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrement:
                state.counter -= 1
                return .none
            case .increment:
                state.counter += 1
                return .none
            case .divide:
                state.divided = Double(state.counter) / 3
                return .none
            }
        }
    }
}
