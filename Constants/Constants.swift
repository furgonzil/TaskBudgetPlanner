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
    static let cornerRadius: CGFloat = 15
    static let padding: CGFloat = 16
}

struct AppTheme {
    static let backgroundPrimary = Color(red: 0.92, green: 0.96, blue: 1.0) // Нежно-голубой
    static let accentPrimary = Color.blue // Насыщенный синий
    static let accentSecondary = Color.blue.opacity(0.2)
    static let textPrimary = Color.black // Контрастный текст
    static let textSecondary = Color.white // Белый текст на темном фоне
    static let inputBorder = Color.blue.opacity(0.6) // Синий для границ ввода
}
