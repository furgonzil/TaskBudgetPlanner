//
//  AddTaskView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var selectedCategory: TaskCategory = .personal
    @State private var dueDate: Date = Date()
    @State private var selectedPriority: TaskPriority = .medium

    var onAdd: (Task) -> Void

    var body: some View {
        VStack {
            Text("Add New Task")
                .font(.headline)
                .padding()

            TextField("Task Title", text: $taskTitle)
                .inputFieldStyle()

            TextField("Task Description", text: $taskDescription)
                .inputFieldStyle()

            Picker("Category", selection: $selectedCategory) {
                ForEach(TaskCategory.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])

            Picker("Priority", selection: $selectedPriority) {
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.title).tag(priority)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Button(action: {
                let newTask = Task(title: taskTitle,
                                  description: taskDescription,
                                  category: selectedCategory,
                                  dueDate: dueDate,
                                  priority: selectedPriority)
                onAdd(newTask)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Task")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.accentPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .padding()
        .frame(width: 600, height: 800)
        .background(AppTheme.backgroundPrimary)
        .cornerRadius(15)
    }
}
