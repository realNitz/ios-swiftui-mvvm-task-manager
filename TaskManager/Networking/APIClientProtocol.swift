//
//  APIEndpoints.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import Foundation

protocol APIClientProtocol {
    func fetchTasks() async throws -> [Task]
}
