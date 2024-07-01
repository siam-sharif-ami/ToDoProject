//
//  HomeView.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var showCreate: Bool = false
    @State var toEditItem: Item?
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<Item> { $0.isCompleted == false},
        sort: \.dueDate ,
        order: .reverse
    ) private var pendingItems: [Item]
    
    @Query(
        filter: #Predicate<Item> {$0.isCompleted == true },
        sort: \.dueDate,
        order: .reverse
    ) private var doneItems: [Item]
    
    var body: some View {
        NavigationStack{
            GeometryReader{ geometry in
                List{
                    Section(header:Text("Pending Items")){
                        ForEach(pendingItems, id:\.id){item in
                            ItemRowView(item: item)
                                .frame(height: geometry.size.height * 0.1)
                                .swipeActions{
                                    Button(role: .destructive){
                                        withAnimation{
                                            modelContext.delete(item)
                                        }
                                    } label : {
                                        Label("Delete", systemImage: "trash")
                                            .symbolVariant(.fill)
                                    }
                                    
                                    Button{
                                        toEditItem = item
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                            .symbolVariant(.fill)
                                    }.tint(.orange)
                                }
                        }
                    }
                    Section(header: Text("Completed")){
                        ForEach(doneItems, id:\.id){item in
                            ItemRowView(item: item)
                                .frame(height: geometry.size.height * 0.1)
                                .swipeActions{
                                    Button(role: .destructive){
                                        withAnimation{
                                            modelContext.delete(item)
                                        }
                                    } label : {
                                        Label("Delete", systemImage: "trash")
                                            .symbolVariant(.fill)
                                    }
                                    
                                    Button{
                                        toEditItem = item
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                            .symbolVariant(.fill)
                                    }.tint(.orange)
                                }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("To Do Lists")
                .toolbar{
                    ToolbarItem{
                        Button(action: {
                            showCreate.toggle()
                        }, label: {
                            Label("Add Item", systemImage: "plus")
                        })
                    }
                }
                .sheet(isPresented: $showCreate, content: {
                    NavigationStack{
                        CreateToDoView()
                    }
                    .presentationDetents([.large])
                })
                .sheet(item: $toEditItem){
                    toEditItem = nil
                } content: { item in
                    EditView(item: item)
                }
            }
        }
    }
    
}

#Preview {
    HomeView()
}
