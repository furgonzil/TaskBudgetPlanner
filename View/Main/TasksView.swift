//
//  TasksView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

struct TasksView: View {
    @State private var tasks: [Task] = []
    @State private var showAddTask = false

    var body: some View {
        VStack {
            Text("Tasks")
                .font(.largeTitle)
                .bold()
                .padding()

            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        Spacer()
                        if task.isCompleted {
                            Text("✓")
                                .foregroundColor(AppTheme.accentPrimary)
                        }
                    }
                }
                .onDelete { indexSet in
                    tasks.remove(atOffsets: indexSet)
                }
            }

            Button(action: { showAddTask.toggle() }) {
                Text("Add Task")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.accentPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .sheet(isPresented: $showAddTask) {
            AddTaskView { newTask in
                tasks.append(newTask)
            }
        }
    }
}
