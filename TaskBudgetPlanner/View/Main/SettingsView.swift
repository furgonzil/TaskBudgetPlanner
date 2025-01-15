//
//  SettingsView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isRegistered") private var isRegistered = true
    @AppStorage("defaultCurrency") private var defaultCurrency = "USD"
    @AppStorage("showDecimals") private var showDecimals = true
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("darkMode") private var darkMode = false
    @State private var showingLogoutAlert = false
    @State private var showingExportSheet = false
    
    private let currencies = ["USD", "EUR", "GBP", "JPY"]
    
    var body: some View {
        NavigationView {
            List {
                Section("Display") {
                    Picker("Default Currency", selection: $defaultCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                    
                    Toggle("Show Decimals", isOn: $showDecimals)
                    Toggle("Dark Mode", isOn: $darkMode)
                }
                
                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $enableNotifications)
                    
                    if enableNotifications {
                        NavigationLink("Configure Notifications") {
                            NotificationSettingsView()
                        }
                    }
                }
                
                Section("Data Management") {
                    Button("Export Data") {
                        showingExportSheet = true
                    }
                    
                    Button("Import Data") {
                        // Import functionality
                    }
                }
                
                Section("Account") {
                    Button("Log Out", role: .destructive) {
                        showingLogoutAlert = true
                    }
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                    Link("Terms of Service", destination: URL(string: "https://example.com/terms")!)
                }
            }
            .navigationTitle("Settings")
            .alert("Log Out", isPresented: $showingLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) {
                    isRegistered = false
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
            .sheet(isPresented: $showingExportSheet) {
                ExportView()
            }
        }
    }
}

struct NotificationSettingsView: View {
    @AppStorage("notifyDueDates") private var notifyDueDates = true
    @AppStorage("notifyBudgetLimit") private var notifyBudgetLimit = true
    @AppStorage("daysBeforeDueDate") private var daysBeforeDueDate = 1
    @AppStorage("budgetWarningPercentage") private var budgetWarningPercentage = 80.0
    
    var body: some View {
        Form {
            Section("Task Notifications") {
                Toggle("Due Date Reminders", isOn: $notifyDueDates)
                
                if notifyDueDates {
                    Stepper("Notify \(daysBeforeDueDate) days before", value: $daysBeforeDueDate, in: 1...7)
                }
            }
            
            Section("Budget Notifications") {
                Toggle("Budget Limit Warnings", isOn: $notifyBudgetLimit)
                
                if notifyBudgetLimit {
                    VStack {
                        Text("Warn at \(Int(budgetWarningPercentage))% of budget")
                        Slider(value: $budgetWarningPercentage, in: 50...90, step: 5)
                    }
                }
            }
        }
        .navigationTitle("Notification Settings")
    }
}

struct ExportView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var exportFormat = ExportFormat.csv
    @State private var dateRange = DateRange.thisMonth
    @State private var isExporting = false
    
    enum ExportFormat: String, CaseIterable {
        case csv = "CSV"
        case json = "JSON"
        case pdf = "PDF"
    }
    
    enum DateRange: String, CaseIterable {
        case thisMonth = "This Month"
        case lastMonth = "Last Month"
        case last3Months = "Last 3 Months"
        case thisYear = "This Year"
        case allTime = "All Time"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Export Format") {
                    Picker("Format", selection: $exportFormat) {
                        ForEach(ExportFormat.allCases, id: \.self) { format in
                            Text(format.rawValue).tag(format)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Date Range") {
                    Picker("Range", selection: $dateRange) {
                        ForEach(DateRange.allCases, id: \.self) { range in
                            Text(range.rawValue).tag(range)
                        }
                    }
                }
                
                Section {
                    Button(action: exportData) {
                        if isExporting {
                            ProgressView()
                                .progressViewStyle(.circular)
                        } else {
                            Text("Export")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Export Data")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func exportData() {
        isExporting = true
        // Implement export logic here
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isExporting = false
            dismiss()
        }
    }
}
