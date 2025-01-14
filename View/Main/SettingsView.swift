//
//  SettingsView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isRegistered") private var isRegistered = true
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account")) {
                    Button(action: { showingLogoutAlert = true }) {
                        Label("Log Out", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Version 1.0")) {
                        Label("Version", systemImage: "info.circle")
                    }
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Log Out")) {
                        isRegistered = false
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
