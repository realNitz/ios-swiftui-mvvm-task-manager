//
//  TaskRowView.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI

struct TaskRowView: View {

    let task: Task
    let onToggle: (Task) -> Void

    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.completed ? .green : .gray)
                .onTapGesture {
                    onToggle(task)
                }

            Text(task.title)
                .strikethrough(task.completed)

            Spacer()
        }    }
}
