//
//  ApiService.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation
import PhotosUI

protocol ApiService {
    func pushImageToFirebase(imageData: Data) async throws -> URL
    func getMockData() async throws -> Content
}
