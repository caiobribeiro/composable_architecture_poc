//
//  AppFeatureTest.swift
//  ComposableArchitecturePocTests
//
//  Created by Caio Beraldi Ribeiro on 07/05/24.
//

import ComposableArchitecture
import XCTest

@testable import ComposableArchitecturePoc

// @MainActor
final class AppFeatureTests: XCTestCase {
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }

        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
