//
//  CustomFont.swift
//  Tolki
//
//  Created by Эльвира on 02.12.2024.
//

import SwiftUI

struct CustomTextStyle: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: .default))
    }
}

extension View {
    func headingTextStyle(size: CGFloat = 48, weight: Font.Weight = .bold) -> some View {
        self.modifier(CustomTextStyle(size: size, weight: weight))
    }
    func buttonTextStyle(size: CGFloat = 16, weight: Font.Weight = .bold) -> some View {
        self.modifier(CustomTextStyle(size: size, weight: weight))
    }
}
