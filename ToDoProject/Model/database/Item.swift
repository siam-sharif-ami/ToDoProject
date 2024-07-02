//
//  Item.swift
//  ToDoProject
//
//  Created by BS00484 on 1/7/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var title:String
    var itemDescription: String
    var image: String?
    var dueDate: Date
    var isCompleted: Bool
    
    init(title: String = "", itemDescription: String = "", image: String? = nil, dueDate: Date = Date.now, isCompleted: Bool = false) {
        self.title = title
        self.itemDescription = itemDescription
        self.image = image
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
