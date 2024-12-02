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
    var secondaryBackgroundColor: Color
}

// набор доступных тем
struct Themes {
    static let light = Theme(
        backgroundColor: Color("MainLight"),
        textColor: Color("Dark"),
        buttonColor: Color("MainGreen"),
        buttonTextColor: Color("Dark"),
        secondaryTextColor: Color("Dark"),
        secondaryBackgroundColor: Color("White")
    )

    static let dark = Theme(
        backgroundColor: Color.black,
        textColor: Color("MainLight"),
        buttonColor: Color.gray,
        buttonTextColor: Color.black,
        secondaryTextColor: Color("MainLight"),
        secondaryBackgroundColor: Color("MainLight")
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
        default:
            currentTheme = Themes.light
        }
    }
}
