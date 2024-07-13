//
//  OnboardingView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 10/06/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var currentTab: Int = 0
    @State private var showMainApp: Bool = false
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            if showMainApp {
                HomeView()
                    .transition(.opacity)
                    .animation(.easeIn(duration: 0.5), value: showMainApp)
            } else {
                TabView(selection: $currentTab, content: {
                    OnboardingSlideView(
                        lottie: "lottie-onboarding-1",
                        title: "Manage your projects",
                        description: "Create, organize and track your projects in a snap.",
                        backgroundColor: .yellow,
                        textColor: .black,
                        buttonAction: {
                            withAnimation {
                                currentTab += 1
                            }
                        },
                        isLastSlide: false
                    ).tag(0)
                    OnboardingSlideView(
                        lottie: "lottie-onboarding-2",
                        title: "Track your earnings",
                        description: "Track earnings effortlessly. Stay updated and in control.",
                        backgroundColor: .white,
                        textColor: .black,
                        buttonAction: {
                            withAnimation {
                                currentTab += 1
                            }
                        },
                        isLastSlide: false
                    ).tag(1)
                    OnboardingSlideView(
                        lottie: "lottie-onboarding-3",
                        title: "Keep your clients",
                        description: "Keep client info organized. Manage relationships with ease.",
                        backgroundColor: .black,
                        textColor: .white,
                        buttonAction: {
                            withAnimation {
                                showMainApp = true
                                hasSeenOnboarding = true
                            }
                        },
                        isLastSlide: true
                    ).tag(2)
                })
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
