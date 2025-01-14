//
//  HomeView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            TasksView()
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }
                .transition(.slide)
            
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.xaxis")
                }
                .transition(.slide)
            
            AddTransactionView()
                .tabItem {
                    Label("Budget", systemImage: "dollarsign.circle")
                }
                .transition(.slide)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .transition(.slide)
        }
        .accentColor(AppTheme.accentPrimary)
    }
}
