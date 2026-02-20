//
//  NetworkError.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case unknown
}
