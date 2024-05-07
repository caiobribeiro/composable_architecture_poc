//
//  NumberFactClientTest.swift
//  ComposableArchitecturePocTests
//
//  Created by Caio Beraldi Ribeiro on 06/05/24.
//

import ComposableArchitecture
import XCTest

@testable import ComposableArchitecturePoc

// @MainActor
final class NumberFactClientTest: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }

        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }

        await store.receive(\.factResponse) {
            $0.isLoading = false
            $0.fact = "0 is a good number."
        }
    }
}
