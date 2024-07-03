//
//  BaseResponse.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation

struct BaseResponse : Decodable {
    
    var id: Int
    var image: String?
    var title: String
    var itemDescription: String?
    var dueDate: Date?
    var completed: Bool
    
    init(id: Int, image: String? = nil, title: String, itemDescription: String = "this is mock data", dueDate: Date = Date.now, completed: Bool = false) {
        self.id = id
        self.image = image
        self.title = title
        self.itemDescription = itemDescription
        self.dueDate = dueDate
        self.completed = completed
    }
    
    
    enum CodingKeys: String, CodingKey {
        // case userID = "userId"
        case id, image, title, itemDescription, dueDate, completed
    }
}

typealias Content = [BaseResponse]
