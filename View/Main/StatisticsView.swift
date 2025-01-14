//
//  StatisticsView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI
import AppKit  // Используем AppKit для macOS

struct StatisticsView: View {
    @StateObject var budgetViewModel = BudgetViewModel()
    @StateObject var taskViewModel = TaskViewModel()
    @State private var selectedPeriod: TimePeriod = .month
    
    enum TimePeriod: String, CaseIterable {
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Period Selector
                    Picker("Time Period", selection: $selectedPeriod) {
                        ForEach(TimePeriod.allCases, id: \.self) { period in
                            Text(period.rawValue).tag(period)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Budget Summary Card
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Budget Summary")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        HStack {
                            StatisticBox(
                                title: "Income",
                                value: budgetViewModel.calculateTotal(for: .income),
                                color: .green
                            )
                            
                            StatisticBox(
                                title: "Expenses",
                                value: budgetViewModel.calculateTotal(for: .expense),
                                color: .red
                            )
                        }
                        
                        let balance = budgetViewModel.calculateTotal(for: .income) - budgetViewModel.calculateTotal(for: .expense)
                        Text("Balance: $\(balance, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(balance >= 0 ? .green : .red)
                    }
                    .cardStyle()
                    
                    // Task Statistics Card
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Task Progress")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        let completedTasks = taskViewModel.tasks.filter { $0.isCompleted }.count
                        let totalTasks = taskViewModel.tasks.count
                        let completionRate = totalTasks > 0 ? Double(completedTasks) / Double(totalTasks) : 0
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Completed")
                                    .foregroundColor(AppTheme.textSecondary)
                                Text("\(completedTasks)/\(totalTasks)")
                                    .font(.title2)
                                    .foregroundColor(AppTheme.accentPrimary)
                            }
                            
                            Spacer()
                            
                            CircularProgressView(progress: completionRate)
                                .frame(width: 60, height: 60)
                        }
                    }
                    .cardStyle()
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent Transactions")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        ForEach(Array(budgetViewModel.transactions.prefix(5))) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                    .cardStyle()
                }
                .padding()
            }
            .navigationTitle("Statistics")
            .background(Color("SecondaryBackground"))
        }
    }
}
