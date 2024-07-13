//
//  OnboardingSlideView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 10/06/24.
//

import SwiftUI
import Lottie

struct OnboardingSlideView: View {
    
    let lottie: String?
    let title: String
    let description: String
    let backgroundColor: Color
    let textColor: Color
    let buttonAction: (() -> Void)?
    let isLastSlide: Bool
    
    @State private var jiggleOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            
            Color(backgroundColor)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 24) {
                LottieView(animation: .named(lottie ?? "lottie-onboarding-1"))
                    .configure({ lottieAnimationView in
                        lottieAnimationView.contentMode = .scaleAspectFit
                    })
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .scaledToFit()
                    .frame(maxWidth: 340)
                
                Text(title)
                    .roundedFont(forSize: .heading)
                    .fontWeight(.black)
                    .foregroundColor(textColor)
                
                Text(description)
                    .roundedFont(forSize: .large)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 38)
                
                if isLastSlide {
                    ButtonView(
                        textButton: "Get Started",
                        textColor: .black,
                        backgroundButton: .white,
                        actionButton: buttonAction
                    )
                    .padding(.vertical, 20)
                    .offset(x: jiggleOffset)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: true)) {
                            jiggleOffset = 10
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                jiggleOffset = 0
                            }
                        }
                    }
                } else {
                    ButtonView(
                        textButton: "➜",
                        textColor: .white,
                        backgroundButton: .black,
                        actionButton: buttonAction
                    )
                    .padding(.vertical, 20)
                }
            }
        }
    }
}

#Preview {
    OnboardingSlideView(
        lottie: "lottie-onboarding-1",
        title: "Manage project",
        description: "Create and manage your project directory with ease",
        backgroundColor: .yellow,
        textColor: .black,
        buttonAction: nil,
        isLastSlide: false
    )
}
