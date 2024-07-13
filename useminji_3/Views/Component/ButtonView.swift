//
//  ButtonView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 10/06/24.
//

import SwiftUI

struct ButtonView: View {
    
    let textButton: String
    let textColor: Color
    let backgroundButton: Color
    let actionButton: (() -> Void)?
    
    var body: some View {
        Button(action: {
            actionButton?() // Call the closure if it exists
        }) {
            Text(textButton)
                .roundedFont(forSize: .large)
                .fontWeight(.black)
                .padding(.vertical, 14)
                .padding(.horizontal, 24)
                .background(backgroundButton)
                .foregroundColor(textColor)
                .cornerRadius(100)
                .padding(.bottom)
        }
    }
}

#Preview {
    ButtonView(
        textButton: "Get started",
        textColor: .white,
        backgroundButton: .black,
        actionButton: nil
    )
}
