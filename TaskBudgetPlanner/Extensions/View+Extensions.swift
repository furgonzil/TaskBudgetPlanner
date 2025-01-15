//
//  View+Extensions.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .padding(Constants.padding)
            .background(AppTheme.backgroundPrimary)
            .cornerRadius(Constants.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(Color(NSColor.separatorColor), lineWidth: 1)
            )
    }

    func inputFieldStyle() -> some View {
        self
            .textFieldStyle(RoundedBorderTextFieldStyle()) // Using standard macOS text field style
            .frame(maxWidth: .infinity)
    }
}
