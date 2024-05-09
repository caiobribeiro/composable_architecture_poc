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
        @Presents var alert: AlertState<Action.Alert>?
        var contacts: IdentifiedArrayOf<Contact> = []
    }

    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
        case deleteButtonTapped(id: Contact.ID)
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
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
                
            case let .deleteButtonTapped(id: id):
                state.alert = AlertState {
                    TextState("Are you sure?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                        TextState("Delete")
                    }
                }
                return .none
            
            case let .alert(.presented(.confirmDeletion(id: id))):
                state.contacts.remove(id: id)
                return .none
                    
            case .alert:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
