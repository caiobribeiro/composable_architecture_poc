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
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    var body: some Scene {
        WindowGroup {
            AppView(store: ComposableArchitecturePocApp.store)
        }
    }
}
