//
//  MockToDoRepositoryImpl.swift
//  ToDoProject
//
//  Created by BS00484 on 2/7/24.
//

import Foundation
class MockToDoRepositoryImpl: ToDoProjectRepository {
    func pushImageToFirebase(imageData: Data) async throws -> URL {
        return URL( string: "hello there , this is mock url ")!
    }
}
