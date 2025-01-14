//
//  CircularProgressView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var color: Color = AppTheme.accentPrimary
    var lineWidth: CGFloat = 8
    var showPercentage: Bool = true
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(color.opacity(0.2), lineWidth: lineWidth)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(color, style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round
                ))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            // Percentage text
            if showPercentage {
                VStack {
                    Text("\(Int(progress * 100))")
                        .font(.system(.title3, design: .rounded))
                        .bold()
                    Text("%")
                        .font(.caption)
                }
                .foregroundColor(color)
            }
        }
        .padding(lineWidth / 2)
    }
}
