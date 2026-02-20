//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
#Preview {
    TaskListView()
}
