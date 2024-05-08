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
    static let storeCounter = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    static let storeContact = Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
    }

    var body: some Scene {
        WindowGroup {
            AppView(store: ComposableArchitecturePocApp.storeCounter, storeContact: ComposableArchitecturePocApp.storeContact)
        }
    }
}
