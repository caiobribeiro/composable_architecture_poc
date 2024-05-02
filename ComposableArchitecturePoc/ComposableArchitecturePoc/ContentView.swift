//
//  ContentView.swift
//  ComposableArchitecturePoc
//
//  Created by Caio Beraldi Ribeiro on 02/05/24.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<CounterFeature>

    var body: some View {
        let formattedNumber = String(format: "%.2f", store.divided)
        VStack {
            Text("counter \(store.counter)")
                .font(.system(size: 60))
            Text("divided \(formattedNumber)")
                .font(.system(size: 60))

            HStack {
                Button {
                    store.send(.decrement)
                } label: {
                    Text("-")
                        .frame(width: 100, height: 100)
                }
                .foregroundColor(.white)
                .background(.blue)
                .font(.largeTitle)

                Button {
                    store.send(.increment)
                } label: {
                    Text("+")
                        .frame(width: 100, height: 100)
                }
                .foregroundColor(.white)
                .background(.blue)
                .font(.largeTitle)
            }
            Button {
                store.send(.divide)
            } label: {
                Text("\(store.counter) / 3")
                    .frame(width: 100, height: 100)
            }
            .foregroundColor(.white)
            .background(.blue)
            .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
                ._printChanges()
        }
    )
}
