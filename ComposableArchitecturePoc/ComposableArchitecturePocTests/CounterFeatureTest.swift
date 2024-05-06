//
//  CounterFeatureTest.swift
//  ComposableArchitecturePocTests
//
//  Created by Caio Beraldi Ribeiro on 05/05/24.
//

import ComposableArchitecture
import XCTest

@testable import ComposableArchitecturePoc

@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await store.receive(\.timerTick, timeout: .seconds(2)) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
}
