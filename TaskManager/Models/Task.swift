//
//  Task.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: Int
    let title: String
    let completed: Bool
}
