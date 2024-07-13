//
//  Text+Extension.swift
//  useminji_3
//
//  Created by Alzea Arafat on 15/05/24.
//

import SwiftUI

enum FontSize {
    case small, regular, medium, large, extraLarge, heading

    var value: CGFloat {
        switch self {
        case .small:
            return 12
        case .regular:
            return 14
        case .medium:
            return 16
        case .large:
            return 20
        case .extraLarge:
            return 24
        case .heading:
            return 28
        }
    }
}

extension Text {
    func roundedFont(forSize size: FontSize) -> some View {
        self.font(.system(size: size.value, design: .rounded))
    }
}
