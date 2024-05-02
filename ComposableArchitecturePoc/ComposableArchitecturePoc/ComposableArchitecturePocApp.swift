//
//  ComposableArchitecturePocApp.swift
//  ComposableArchitecturePoc
//
//  Created by Caio Beraldi Ribeiro on 02/05/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct ComposableArchitecturePocApp: App {
    private static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: ComposableArchitecturePocApp.store)
        }
    }
}
