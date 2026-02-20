//
//  TaskService.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import Foundation

protocol TaskServiceProtocol {
    func getTasks() async throws -> [Task]
}

final class TaskService: TaskServiceProtocol {

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getTasks() async throws -> [Task] {
        try await apiClient.fetchTasks()
    }
}
