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
    }
}
