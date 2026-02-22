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
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    List {
                        ForEach(viewModel.tasks) { task in
                            HStack {
                                Text(task.title)
                                Spacer()
                                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedTask = task
                            }
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .sheet(item: $selectedTask) { task in
                           EditTaskView(task: task) { newTitle in
                               viewModel.updateTask(task, newTitle: newTitle)
                           }
                       }


                }
            }
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

            
        }
    }
}
