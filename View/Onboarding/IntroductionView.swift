//
//  IntroductionView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

struct IntroductionView: View {
    @State private var name: String = ""
    @AppStorage("isRegistered") private var isRegistered = false
    @State private var currentPage = 0

    let onboardingPages = [
        OnboardingPage(title: "Welcome to Task & Budget Planner",
                      description: "Your all-in-one solution for managing tasks and finances",
                      systemImage: "star.fill"),
        OnboardingPage(title: "Track Your Tasks",
                      description: "Create, organize, and complete tasks efficiently",
                      systemImage: "checklist"),
        OnboardingPage(title: "Manage Your Budget",
                      description: "Keep track of your income and expenses",
                      systemImage: "dollarsign.circle")
    ]

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingPages.count, id: \.self) { index in
                    OnboardingView(page: onboardingPages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(DefaultTabViewStyle()) // Используем стиль, совместимый с macOS

            HStack {
                Spacer()
                Button("Previous") {
                    if currentPage > 0 {
                        currentPage -= 1
                    }
                }
                .disabled(currentPage == 0)

                Spacer()

                Button(currentPage == onboardingPages.count - 1 ? "Finish" : "Next") {
                    if currentPage < onboardingPages.count - 1 {
                        currentPage += 1
                    } else {
                        isRegistered = true
                    }
                }
                .disabled(currentPage == onboardingPages.count - 1 && name.isEmpty)

                Spacer()
            }
            .padding()
        }
        .overlay(
            VStack {
                Spacer()
                if currentPage == onboardingPages.count - 1 {
                    VStack {
                        TextField("What's your name?", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Button(action: { isRegistered = true }) {
                            Text("Get Started")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.accentPrimary)
                                .foregroundColor(name.isEmpty ? AppTheme.textSecondary : AppTheme.backgroundPrimary)
                                .cornerRadius(Constants.cornerRadius)
                                .shadow(radius: 10)
                        }
                        .disabled(name.isEmpty)
                    }
                    .background(AppTheme.backgroundPrimary)
                    .cornerRadius(Constants.cornerRadius)
                    .padding()
                }
            }
        )
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let systemImage: String
}

struct OnboardingView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.systemImage)
                .font(.system(size: 80))
                .foregroundColor(AppTheme.accentPrimary)
                .padding()
                .background(
                    Circle()
                        .fill(AppTheme.accentSecondary)
                        .frame(width: 150, height: 150)
                )
                .shadow(color: Color.blue.opacity(0.1), radius: 10) // Using a default shadow color

            Text(page.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(AppTheme.textPrimary)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(AppTheme.textSecondary)
                .padding(.horizontal)
        }
        .padding()
    }
}
