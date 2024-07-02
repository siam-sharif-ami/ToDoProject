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
    
    
    var body: some View {
        
        KFImage(dummyVm.url)
        
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
        
    }
}


#Preview {
    TestView(dummyVm: HomeViewModel())
}
