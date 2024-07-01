//
//  CreateToDoView.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import SwiftUI

struct CreateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var item = Item()
    
    var body: some View {
        List{
            TextField("Title", text: $item.title)
            TextField("Description", text: $item.itemDescription)
            DatePicker("Choose a date", selection: $item.dueDate)
            Toggle("Completed?", isOn: $item.isCompleted)
            Button("Create"){
                withAnimation{
                    context.insert(item)
                }
                dismiss()
            }
        }
    }
}

#Preview {
    CreateToDoView()
}
