//
//  TaskViewModel.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        loadTasks()
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
        if let index = tasks.firstIndex(where: { $0.id == taskID }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            userDefaults.set(encoded, forKey: "tasks")
        }
    }
    
    private func loadTasks() {
        if let data = userDefaults.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        } else {
            loadPreviewTasks()
        }
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
