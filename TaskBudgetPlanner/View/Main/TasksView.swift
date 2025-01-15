//
//  TasksView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

struct TasksView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showAddTask = false
    @State private var searchText = ""
    
    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return viewModel.tasks
        }
        return viewModel.tasks.filter { task in
            task.title.localizedCaseInsensitiveContains(searchText) ||
            task.description.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTasks) { task in
                    TaskRow(task: task, onToggle: viewModel.toggleTaskCompletion)
                }
                .onDelete { indexSet in
                    viewModel.removeTask(at: indexSet)
                }
            }
            .searchable(text: $searchText, prompt: "Search tasks")
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showAddTask.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddTask) {
            AddTaskView { newTask in
                viewModel.tasks.append(newTask)
            }
        }
    }
}

struct TaskRow: View {
    let task: Task
    let onToggle: (UUID) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .gray)
                .onTapGesture {
                    onToggle(task.id)
                }
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Label(task.category.rawValue, systemImage: task.category.icon)
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(task.dueDate, style: .date)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Circle()
                .fill(task.priority.color)
                .frame(width: 12, height: 12)
        }
        .padding(.vertical, 4)
    }
}
