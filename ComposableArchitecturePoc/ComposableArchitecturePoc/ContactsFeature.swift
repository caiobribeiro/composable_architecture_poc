//
//  ContactsFeature.swift
//  ComposableArchitecturePoc
//
//  Created by Caio Beraldi Ribeiro on 08/05/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }

    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
                return .none

//            case .addContact(.presented(.cancelButtonTapped)):
//                state.addContact = nil
//                return .none

            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                // state.addContact = nil
                state.contacts.append(contact)
                state.addContact = nil
                return .none

            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}
