//
//  TaskRowView.swift
//  TaskManager
//
//  Created by Nitesh Parihar on 20/02/26.
//

import SwiftUI

struct TaskRowView: View {

    let task: Task

    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.completed ? .green : .gray)
        }
    }
}
