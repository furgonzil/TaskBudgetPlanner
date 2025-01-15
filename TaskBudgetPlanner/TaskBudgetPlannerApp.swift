//
//  TaskBudgetPlannerApp.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

@main
struct TaskBudgetPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .frame(minWidth: 800, idealWidth: 800, maxWidth: 800,
                       minHeight: 800, idealHeight: 800, maxHeight: 800)
        }
        .windowStyle(HiddenTitleBarWindowStyle()) // Убираем заголовок окна
        .commands {
            CommandMenu("Custom Shortcuts") {
                Button("New Task", action: newTask)
                    .keyboardShortcut("n", modifiers: .command)
                
                Button("New Transaction", action: newTransaction)
                    .keyboardShortcut("t", modifiers: .command)
                
                Button("Search", action: search)
                    .keyboardShortcut("f", modifiers: .command)
                
                Button("Save", action: save)
                    .keyboardShortcut("s", modifiers: .command)
                
                Button("Toggle Sidebar", action: toggleSidebar)
                    .keyboardShortcut("b", modifiers: .command)
            }
        }
    }
    
    func newTask() {
        print("New Task action triggered")
    }
    
    func newTransaction() {
        print("New Transaction action triggered")
    }
    
    func search() {
        print("Search action triggered")
    }
    
    func save() {
        print("Save action triggered")
    }
    
    func toggleSidebar() {
        print("Toggle Sidebar action triggered")
    }
}
