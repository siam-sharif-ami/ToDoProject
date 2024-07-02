//
//  UpdateToDoView.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var item: Item
    @State var viewModel: HomeViewModel
    @State var photoPickerItem: PhotosPickerItem?
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
                    if let image = item.image {
                        KFImage(URL(string:image))
                            .resizable()
                            .frame(width: 350, height: 150)
                            .cornerRadius(10)
                    }else{
                        HStack{
                            Text("Select an Image")
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            TextField("Title", text: $item.title)
            TextField("Description", text: $item.itemDescription)
            DatePicker("Choose a date", selection: $item.dueDate, in: Date()...)
            Toggle("Completed?", isOn: $item.isCompleted)
            Button("Done"){
                Task{
                    isLoading = true
                    if let photoPickerItem,
                       let data = try? await photoPickerItem.loadTransferable(type: Data.self){
                        let urlString = try await viewModel.getImageURLString(imageData: data)
                        item.image = urlString
                    }
                    isLoading = false
                    dismiss()
                }
            }
            .navigationTitle("Update to do")
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

//#Preview {
//    EditView(item:Item)
//}
