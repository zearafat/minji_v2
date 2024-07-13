//
//  SplashScreenView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 20/06/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive: Bool = false
    @State private var size: Double = 0.0
    @State private var opacity: Double = 0.0
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some View {
        if isActive {
            if hasSeenOnboarding {
                HomeView()
            } else {
                OnboardingView()
            }
        } else {
            ZStack {
                Color(.yellow)
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 24) {
                        Image("splash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240)
                            .foregroundColor(.yellow)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.bouncy(duration: 1, extraBounce: 0.15)) {
                            self.size = 0.8
                            self.opacity = 1.0
                        }
                    }
                    Spacer()
                }
                .ignoresSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeIn(duration: 0.5)) {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
