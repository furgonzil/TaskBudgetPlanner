//
//  StatisticsView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @StateObject private var budgetViewModel = BudgetViewModel()
    @StateObject private var taskViewModel = TaskViewModel()
    @State private var selectedPeriod: TimePeriod = .month
    @State private var showingBudgetSheet = false
    
    enum TimePeriod: String, CaseIterable {
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Budget Overview
                    GroupBox("Budget Overview") {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("Monthly Budget:")
                                Spacer()
                                Text("$\(budgetViewModel.monthlyBudget, specifier: "%.2f")")
                                    .bold()
                            }
                            
                            ProgressView(
                                value: budgetViewModel.getBudgetProgress(),
                                total: 1.0
                            )
                            .tint(budgetViewModel.getBudgetProgress() > 0.9 ? .red : .accentColor)
                            
                            HStack {
                                Text("Spent:")
                                Spacer()
                                Text("$\(budgetViewModel.calculateTotal(for: .expense), specifier: "%.2f")")
                            }
                            .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Expense Categories Chart
                    if !budgetViewModel.totalsByCategory(type: .expense).isEmpty {
                        GroupBox("Expense Categories") {
                            Chart {
                                ForEach(budgetViewModel.totalsByCategory(type: .expense), id: \.0) { category, amount in
                                    SectorMark(
                                        angle: .value("Amount", amount),
                                        innerRadius: .ratio(0.618),
                                        angularInset: 1.0
                                    )
                                    .foregroundStyle(by: .value("Category", category.rawValue))
                                }
                            }
                            .frame(height: 200)
                            .padding()
                        }
                        .padding(.horizontal)
                    }
                    
                    // Task Progress
                    GroupBox("Task Progress") {
                        let completedTasks = taskViewModel.tasks.filter(\.isCompleted).count
                        let totalTasks = taskViewModel.tasks.count
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("Completion Rate:")
                                Spacer()
                                Text("\(Int((Double(completedTasks) / Double(max(1, totalTasks))) * 100))%")
                                    .bold()
                            }
                            
                            ProgressView(
                                value: Double(completedTasks),
                                total: Double(max(1, totalTasks))
                            )
                            
                            HStack {
                                Text("Tasks Completed:")
                                Spacer()
                                Text("\(completedTasks) of \(totalTasks)")
                            }
                            .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Statistics")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingBudgetSheet = true }) {
                        Label("Set Budget", systemImage: "dollarsign.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showingBudgetSheet) {
            SetBudgetView(viewModel: budgetViewModel)
        }
    }
}

struct SetBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BudgetViewModel
    @State private var budgetAmount = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Monthly Budget") {
                    TextField("Amount", text: $budgetAmount)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .navigationTitle("Set Budget")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let amount = Double(budgetAmount) {
                            viewModel.setMonthlyBudget(amount)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
