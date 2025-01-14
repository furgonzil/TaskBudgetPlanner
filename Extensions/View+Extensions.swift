//
//  View+Extensions.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

//
//  View+Extensions.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .padding(Constants.padding)
            .background(AppTheme.backgroundPrimary)
            .cornerRadius(Constants.cornerRadius)
            .shadow(color: AppTheme.accentSecondary, radius: 10)
    }

    func inputFieldStyle() -> some View {
        self
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.inputBorder, lineWidth: 2)
            )
            .shadow(radius: 2)
    }
}
