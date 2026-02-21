//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI

struct AddTaskView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""

    let onAdd: (String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Title")) {
                    TextField("Enter task title", text: $title)
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onAdd(title)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
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
//#Preview {
//    AddTaskView { _ in }
//}

