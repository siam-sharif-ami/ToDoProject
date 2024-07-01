//
//  ContentView.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View{
        Text("Hello world")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
