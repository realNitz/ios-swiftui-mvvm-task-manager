//
//  APIClient.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import Foundation

final class APIClient: APIClientProtocol {

    func fetchTasks() async throws -> [Task] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Task].self, from: data)
    }
}
