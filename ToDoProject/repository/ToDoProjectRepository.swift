//
//  ToDoProjectRepository.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation

protocol ToDoProjectRepository{
    func pushImageToFirebase(imageData: Data) async throws -> URL
}
