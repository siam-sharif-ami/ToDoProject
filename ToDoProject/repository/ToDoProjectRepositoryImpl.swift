//
//  ToDoProjectRepositoryImpl.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation

class ToDoProjectRepositoryImpl: ToDoProjectRepository {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func pushImageToFirebase(imageData: Data) async throws -> URL {
        let response = try await apiService.pushImageToFirebase(imageData: imageData)
        return response
    }
}
