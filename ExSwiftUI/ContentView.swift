//
//  ContentView.swift
//  ExSwiftUI
//
//  Created by 김종권 on 2024/04/20.
//

import SwiftUI

struct ContentView: View {
    enum ViewState {
        case loading
        case success
        case failed
    }
    
    @State private var items = [Person(id: "1", age: 10, name: "jake")]
    @State private var state = ViewState.loading
    
    var body: some View {
        Group {
            switch state {
            case .loading:
                VStack {
                    Text("loading...")
                    ProgressView()
                }
            case .success:
                List(items) { person in
                    PersonRowView(item: person)
                        .onAppear {
                            if person.id == items.last?.id {
                                Task {
                                    await loadMoreItems()
                                }
                            }
                        }
                }
            case .failed:
                VStack {
                    Text("Failed!!")
                    
                    Button("Retry") {
                        state = .loading
                        Task {
                            try await Task.sleep(nanoseconds: 500_000_000)
                            state = .success
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("This is navigationTitle")
        .onAppear(perform: {
            Task {
                try await Task.sleep(nanoseconds: 500_000_000)
                state = .failed
            }
        })
        .task(loadMoreItems)
    }
    
    @Sendable func loadMoreItems() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        let mocks = [
            Person(id: Date.now.description, age: 10, name: "jake1"),
            Person(id: Date.now.description + "1", age: 20, name: "jake2"),
            Person(id: Date.now.description + "2", age: 30, name: "jake3"),
            Person(id: Date.now.description + "3", age: 40, name: "jake4"),
            Person(id: Date.now.description + "4", age: 50, name: "jake5"),
            Person(id: Date.now.description + "5", age: 60, name: "jake6"),
            Person(id: Date.now.description + "6", age: 20, name: "jake7"),
            Person(id: Date.now.description + "7", age: 30, name: "jake8"),
            Person(id: Date.now.description + "8", age: 40, name: "jake9"),
            Person(id: Date.now.description + "9", age: 50, name: "jake10"),
            Person(id: Date.now.description + "10", age: 60, name: "jake11"),
            Person(id: Date.now.description + "11", age: 20, name: "jake12"),
            Person(id: Date.now.description + "12", age: 30, name: "jake13"),
            Person(id: Date.now.description + "13", age: 40, name: "jake14"),
            Person(id: Date.now.description + "14", age: 50, name: "jake15"),
            Person(id: Date.now.description + "15", age: 60, name: "jake16"),
        ]
        items.append(contentsOf: mocks)
    }
}

#Preview {
    ContentView()
}
