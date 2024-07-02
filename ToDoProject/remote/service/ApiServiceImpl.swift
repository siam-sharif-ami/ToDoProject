//
//  ApiServiceImpl.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation
import Firebase
import FirebaseStorage

class ApiServiceImpl : ApiService {
    private var baseURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/todo-b06b4.appspot.com/o/")
    
    init(baseURL: URL? = nil){
        if let baseURL = baseURL{
            self.baseURL = baseURL
        }
    }
    
    func pushImageToFirebase(imageData: Data) async throws -> URL {
        let storageRef = Storage.storage().reference()
        let imagePath = storageRef.child("images")
        
        let imageName = UUID().uuidString + ".*"
        let imageRef = imagePath.child(imageName)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void,Error>) in
            imageRef.putData(imageData, metadata: metadata){metadata, error in
                if let error = error {
                    print("failure uploading data \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                }else {
                    continuation.resume(returning: ())
                }
            }
        }
        
        
        
        let url = try await imageRef.downloadURL()
        print("the downloaded url is : -----> \(url) ")
        return url
    }
}
