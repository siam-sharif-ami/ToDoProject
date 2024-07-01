//
//  ApiResponse.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import Foundation

class ApiResponse {
    var title: String
    var completed: Bool
    
    init(title: String, completed: Bool) {
        self.title = title
        self.completed = completed
    }
}

