//
//  HomeViewModel.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation

@available(iOS 17.0, *)
@Observable
class HomeViewModel {
    
    var repository: ToDoProjectRepository
    var url: URL?
    
    init(repository: ToDoProjectRepository = ToDoProjectRepositoryImpl(apiService: ApiServiceImpl())) {
        self.repository = repository
    }
    
    func getImageURLString(imageData: Data) async throws -> String {
        
        do{
            url = try await repository.pushImageToFirebase(imageData: imageData)
            print("Url response: \(url?.absoluteString ?? "unknown")")
        }catch {
            print("Error: \(error.localizedDescription)")
        }
        return url?.absoluteString ?? "Unknown"
    }
    
}
