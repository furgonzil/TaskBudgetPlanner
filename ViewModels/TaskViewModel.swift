//
//  TaskViewModel.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    init() {
        loadPreviewTasks()
    }

    func addTask(title: String, description: String, category: TaskCategory, dueDate: Date, priority: TaskPriority) {
        let newTask = Task(
            title: title,
            description: description,
            category: category,
            dueDate: dueDate,
            priority: priority
        )
        tasks.append(newTask)
    }

    func removeTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }

    func toggleTaskCompletion(taskID: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        tasks[index].isCompleted.toggle()
    }

    private func loadPreviewTasks() {
        tasks = [
            Task.preview(),
            Task(
                title: "Buy groceries",
                description: "Need to buy milk, eggs, and bread",
                category: .shopping,
                dueDate: Date().addingTimeInterval(3600 * 5),
                priority: .high
            ),
            Task(
                title: "Workout",
                description: "Go for a run or hit the gym",
                category: .health,
                dueDate: Date().addingTimeInterval(3600 * 8),
                priority: .medium
            )
        ]
    }
}
