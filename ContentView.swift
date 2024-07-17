//
//  ContentView.swift
//  RealmDemo
//
//  Created by Samuel on 7/17/24.
//

import SwiftUI
import R

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}




class Todo: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var ownerId: String
    convenience init(name: String, ownerId: String) {
        self.init()
        self.name = name
        self.ownerId = ownerId
    }
}
