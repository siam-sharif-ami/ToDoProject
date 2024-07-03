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
    private var baseURL: URL?
    
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
    
    
    
    func getMockData() async throws -> Content {
        let endPoint = "https://jsonplaceholder.typicode.com/users/1/todos"
        
        print(endPoint)
        
        guard let url = URL(string: endPoint) else {
            throw fetchSearchResponseError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("response not found ")
            throw fetchSearchResponseError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Content.self, from: data)
            return decodedData
            
        }catch{
            print("Error decoding data to content")
            throw fetchSearchResponseError.invalidData
        }
    }
}

enum fetchSearchResponseError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
