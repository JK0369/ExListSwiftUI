//
//  PersonRowView.swift
//  ExSwiftUI
//
//  Created by 김종권 on 2024/04/20.
//

import SwiftUI

struct PersonRowView: View {
    let item: Person
    
    var body: some View {
        NavigationLink {
            Text("detail")
        } label: {
            HStack {
                Text("age: \(item.age), name: \(item.name)")
                    .font(.caption.weight(.heavy))
            }
        }
    }
}

#Preview {
    PersonRowView(item: .init(id: "1", age: 20, name: "jake"))
}
