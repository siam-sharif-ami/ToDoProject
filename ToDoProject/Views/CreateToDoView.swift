//
//  CreateToDoView.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct CreateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var item = Item()
    @State var photoPickerItem: PhotosPickerItem?
    @State var viewModel: HomeViewModel
    @State var selectedImage: UIImage?
    @State private var isLoading: Bool = false
    
    var body: some View {
        List{
            PhotosPicker(selection: $photoPickerItem) {
                if let selected = selectedImage {
                    Image(uiImage: selected)
                        .resizable()
                        .scaledToFit()
                }else {
                    HStack{
                        Text("Select an Image")
                        Image(systemName: "plus")
                    }
                }
            }
            TextField("Title", text: $item.title)
            TextField("Description", text: $item.itemDescription)
            DatePicker("Choose a date", selection: $item.dueDate, in: Date()...)
            Toggle("Completed?", isOn: $item.isCompleted)
            Button(action: {
                Task{
                    isLoading = true
                    if let photoPickerItem,
                       let data = try? await photoPickerItem.loadTransferable(type: Data.self){
                        let urlString = try await viewModel.getImageURLString(imageData: data)
                        item.image = urlString
                    }
                    withAnimation{
                        context.insert(item)
                    }
                    isLoading = false
                    dismiss()
                }
            }) {
                Text("Create")
                    .foregroundColor(isInputValid() ? .blue : .gray)
                    
                }
            .disabled(!isInputValid())
            .onChange(of: photoPickerItem) { _, _ in
                Task{
                    if let photoPickerItem,
                       let data = try? await photoPickerItem.loadTransferable(type: Data.self){
                        if let image = UIImage(data: data){
                            selectedImage = image
                        }
                    }
                }
            }
            if isLoading {
                ProgressView().padding().background(Color.white).cornerRadius(5)
            }
        }
    }
}
private extension CreateToDoView{
    func isInputValid() -> Bool{
        return !item.title.isEmpty && !item.itemDescription.isEmpty
    }
}

#Preview {
    CreateToDoView(viewModel: HomeViewModel())
}
