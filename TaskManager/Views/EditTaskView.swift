//
//  EditTaskView.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 21/02/26.
//

import SwiftUI

struct EditTaskView: View {

    let task: Task
    let onSave: (String) -> Void

    @State private var title: String
    @Environment(\.dismiss) private var dismiss

    init(task: Task, onSave: @escaping (String) -> Void) {
        self.task = task
        self.onSave = onSave
        _title = State(initialValue: task.title)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Title")) {
                    TextField("Enter title", text: $title)
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
