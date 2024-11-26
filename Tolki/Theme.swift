//
//  Theme.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

// структура для определения темы
struct Theme {
    var backgroundColor: Color
    var textColor: Color
    var buttonColor: Color
    var buttonTextColor: Color
    var secondaryTextColor: Color
}

// набор доступных тем
struct Themes {
    static let light = Theme(
        backgroundColor: Color.white,
        textColor: Color.black,
        buttonColor: Color.blue,
        buttonTextColor: Color.white,
        secondaryTextColor: Color.black
    )

    static let dark = Theme(
        backgroundColor: Color.black,
        textColor: Color.white,
        buttonColor: Color.gray,
        buttonTextColor: Color.black,
        secondaryTextColor: Color.white
    )

    static let blue = Theme(
        backgroundColor: Color.blue.opacity(0.1),
        textColor: Color.blue,
        buttonColor: Color.blue,
        buttonTextColor: Color.white,
        secondaryTextColor: Color.blue
    )
}

// менеджер тем
class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") var selectedTheme: String = "light" {
        didSet {
            switch selectedTheme {
            case "light":
                currentTheme = Themes.light
            case "dark":
                currentTheme = Themes.dark
            case "blue":
                currentTheme = Themes.blue
            default:
                currentTheme = Themes.light
            }
        }
    }

    @Published var currentTheme: Theme = Themes.light

    init() {
        switch selectedTheme {
        case "light":
            currentTheme = Themes.light
        case "dark":
            currentTheme = Themes.dark
        case "blue":
            currentTheme = Themes.blue
        default:
            currentTheme = Themes.light
        }
    }
}
