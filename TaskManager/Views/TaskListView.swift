//
//  TaskListView.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI

struct TaskListView: View {

    @StateObject private var viewModel = TaskListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.tasks) { task in
                        TaskRowView(task: task)
                    }
                }
            }
            .navigationTitle("Tasks")
            .task {
                await viewModel.loadTasks()
            }
        }
    }
}
