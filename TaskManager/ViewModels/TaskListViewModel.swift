//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI
import Combine

final class TaskListViewModel: ObservableObject {

    @Published var tasks: [Task] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isRefreshing: Bool = false

    
    private let taskService: TaskServiceProtocol

    init(taskService: TaskServiceProtocol = TaskService()) {
        self.taskService = taskService
    }

    @MainActor
    func loadTasks(isRefresh: Bool = false) async {
        if isRefresh {
            isRefreshing = true
        } else {
            isLoading = true
            errorMessage = nil
        }

        do {
            let result = try await taskService.getTasks()
            tasks = result
        } catch {
            if !isRefresh {
                errorMessage = "Unable to load tasks"
            }
        }

        isLoading = false
        isRefreshing = false
    }
    
    @MainActor
    func addTask(title: String) {
        let newTask = Task(
            id: (tasks.map { $0.id }.max() ?? 0) + 1,
            title: title,
            completed: false
        )
        tasks.insert(newTask, at: 0)
    }

    @MainActor
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    @MainActor
    func toggleCompletion(for task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].completed.toggle()
    }

    @MainActor
    func updateTask(_ task: Task, newTitle: String) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].title = newTitle
    }

}
