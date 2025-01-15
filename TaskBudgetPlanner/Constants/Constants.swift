//
//  Constants.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

//
//  Constants.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

enum Constants {
    static let cornerRadius: CGFloat = 8 // Standard macOS corner radius
    static let padding: CGFloat = 16
}

struct AppTheme {
    // Using system colors for better integration
    static let backgroundPrimary = Color(NSColor.windowBackgroundColor)
    static let accentPrimary = Color.accentColor
    static let accentSecondary = Color.accentColor.opacity(0.2)
    static let textPrimary = Color(NSColor.labelColor)
    static let textSecondary = Color(NSColor.secondaryLabelColor)
    static let inputBorder = Color(NSColor.separatorColor)
}
