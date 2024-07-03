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
    @Environment(\.modelContext) var modelContext
    @State var viewModel = HomeViewModel()
    @State var mockDataPlaceHolder: Content = []
    
    @Query(
        filter: #Predicate<Item> { $0.isCompleted == false},
        sort: \.dueDate ,
        order: .forward
    ) private var pendingItems: [Item]
    
    @Query(
        filter: #Predicate<Item> {$0.isCompleted == true },
        sort: \.dueDate,
        order: .forward
    ) private var doneItems: [Item]
    
    var body: some View {
        NavigationStack{
            List{
                Section(header:Text("Pending Items")){
                    if pendingItems.isEmpty {
                        HStack{
                            Image(systemName: "list.dash")
                            Text("No Items found")
                        }
                    }else {
                        ForEach(pendingItems, id:\.id){item in
                            ItemRowView(item: item)
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
                Section(header: Text("Completed")){
                    if doneItems.isEmpty{
                        HStack{
                            Image(systemName: "list.dash")
                            Text("No Items found")
                        }
                    }else {
                        ForEach(doneItems, id:\.id){item in
                            ItemRowView(item: item)
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
                    CreateToDoView(viewModel: viewModel)
                }
                .presentationDetents([.large])
            })
            .sheet(item: $toEditItem){
                toEditItem = nil
            } content: { item in
                EditView(item: item,viewModel: viewModel)
            }
            
        }
        .onChange(of: pendingItems){ _ in
            checkAndLoadMockData()
        }
        .onChange(of: doneItems){ _ in
            checkAndLoadMockData()
        }
        .onAppear(){
            checkAndLoadMockData()
        }
    }
    
}
private extension HomeView {
    func checkAndLoadMockData(){
        if pendingItems.isEmpty && doneItems.isEmpty {
            Task{
                do{
                    mockDataPlaceHolder = try await viewModel.repository.getMockData()
                    for data in mockDataPlaceHolder {
                        let item = Item(title: data.title, itemDescription: data.itemDescription ?? "This is a mock data", dueDate: data.dueDate ?? Date.now, isCompleted: data.completed)
                        modelContext.insert(item)
                    }
                    mockDataPlaceHolder = []
                }catch {
                    print("Error fetching mock data from api ")
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
