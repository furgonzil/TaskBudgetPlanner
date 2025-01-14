//
//   AddTransactionView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI
import Combine
import AppKit

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var budgetViewModel = BudgetViewModel()
    
    @State private var amount: String = ""
    @State private var selectedType: TransactionType = .income
    @State private var selectedCategory: TransactionCategory = .other
    @State private var note: String = ""
    @State private var isRecurring: Bool = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Using NumberFormatter for decimal input
                    TextField("Enter amount", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color("SecondaryBackground"))
                        .cornerRadius(Constants.cornerRadius)
                        .onReceive(Just(amount)) { newValue in
                            // Filter non-numeric characters except decimal point
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                self.amount = filtered
                            }
                            // Ensure only one decimal point
                            if filtered.filter({ $0 == "." }).count > 1 {
                                let components = filtered.components(separatedBy: ".")
                                self.amount = components[0] + "." + components[1...].joined()
                            }
                        }
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach([TransactionType.income, .expense], id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(TransactionCategory.allCases, id: \.self) { category in
                            Label(category.rawValue, systemImage: category.icon)
                                .tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Note", text: $note)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Toggle("Recurring Transaction", isOn: $isRecurring)
                        .padding()
                    
                    Button(action: addTransaction) {
                        Text("Add Transaction")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.accentPrimary)
                            .foregroundColor(.white)
                            .cornerRadius(Constants.cornerRadius)
                    }
                    .buttonStyle(PlainButtonStyle()) // Исправлено использование кастомного стиля для кнопки
                    .shadow(radius: 5) // Добавлено тень для кнопки

                }
                .padding()
                .navigationTitle("Add Transaction")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func addTransaction() {
        guard let amountValue = Double(amount), amountValue > 0 else {
            alertMessage = "Please enter a valid amount"
            showingAlert = true
            return
        }
        
        let transaction = Transaction(
            amount: amountValue,
            note: note, type: selectedType,
            category: selectedCategory,
            date: Date()
        )
        
        budgetViewModel.addTransaction(transaction)
        presentationMode.wrappedValue.dismiss()
    }

}
