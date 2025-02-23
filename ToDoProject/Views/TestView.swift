//
//  TestVierw.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct TestView: View {
    @State var avatarImage: UIImage?
    @State var photoPickerItem: PhotosPickerItem?
    @State var dummyVm: HomeViewModel
    @State var mockDataPlaceHolder: Content = []
    
    var body: some View {
        Text("Done")
        KFImage(dummyVm.url)
        
       
        List{
            ForEach(mockDataPlaceHolder, id: \.id){ item in
                let itemMade = Item(title: item.title, itemDescription: item.itemDescription ?? "This is mock data", dueDate: item.dueDate ?? Date.now, isCompleted: item.completed)
                ItemRowView(item: itemMade)
            }
        }
        
        PhotosPicker(selection: $photoPickerItem) {
            if avatarImage == nil {
                Image(systemName: "person")
            }else {
                Image(uiImage: avatarImage!)
                    .resizable()
                    .scaledToFit()
            }
        }
        .onChange(of: photoPickerItem) { _, _ in
            Task{
                if let photoPickerItem,
                   let data = try? await photoPickerItem.loadTransferable(type: Data.self){
                    let url = try await dummyVm.getImageURLString(imageData: data)
                    print(url)
                    if let image = UIImage(data: data){
                        avatarImage = image
                    }
                }
                photoPickerItem = nil
            }
        }
        .onAppear(){
            Task{
                do{
                    mockDataPlaceHolder = try await dummyVm.repository.getMockData()
                }catch{
                    print("failed to retrieve dummy data from api ")
                }
            }
        }
        
    }
}


#Preview {
    TestView(dummyVm: HomeViewModel())
}
