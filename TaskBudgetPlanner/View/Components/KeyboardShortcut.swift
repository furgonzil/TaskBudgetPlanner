//
//  KeyboardShortcut.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 15.01.25.
//

import SwiftUI

struct KeyboardShortcut {
    let key: KeyEquivalent
    let modifiers: EventModifiers

    static let newTask = KeyboardShortcut(key: "n", modifiers: .command)
    static let newTransaction = KeyboardShortcut(key: "t", modifiers: .command)
    static let search = KeyboardShortcut(key: "f", modifiers: .command)
    static let save = KeyboardShortcut(key: "s", modifiers: .command)
    static let toggleSidebar = KeyboardShortcut(key: "b", modifiers: .command)
}

struct ShortcutModifier: ViewModifier {
    let shortcut: KeyboardShortcut
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                // Add any additional setup if necessary
            }
    }
}
