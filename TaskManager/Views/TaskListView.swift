//
//  TaskListView.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI

struct TaskListView: View {

    @State private var showAddTask = false
    @State private var selectedTask: Task?

    @StateObject private var viewModel = TaskListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Tasks")
                .task {
                    await viewModel.loadTasks()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddTask = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddTask) {
                    AddTaskView { title in
                        viewModel.addTask(title: title)
                    }
                }
                .sheet(item: $selectedTask) { task in
                    EditTaskView(task: task) { newTitle in
                        viewModel.updateTask(task, newTitle: newTitle)
                    }
                }
        }
    }

    // MARK: - Content View
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
            Text(error)
                .foregroundColor(.red)
        } else {
            List {
                ForEach(viewModel.tasks) { task in
                    taskRow(task)
                }
            }
            .listStyle(.plain)
        }
    }

    // MARK: - Task Row
    @ViewBuilder
    private func taskRow(_ task: Task) -> some View {
        HStack {
            Text(task.title)
                .strikethrough(task.completed)
            Spacer()
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    viewModel.toggleCompletion(for: task)
                }
        }
        .contentShape(Rectangle()) // IMPORTANT for swipe + tap
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                    viewModel.deleteTask(at: IndexSet(integer: index))
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                selectedTask = task
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
    }
}
