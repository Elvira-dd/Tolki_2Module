//
//  Theme.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI


struct Theme {
var backgroundColor: Color
var textColor: Color
var buttonColor: Color
var buttonTextColor: Color
}
struct Themes {
static let light = Theme(
backgroundColor: Color.white,
textColor: Color.black,
buttonColor: Color.blue,
buttonTextColor: Color.white
)
static let dark = Theme(
backgroundColor: Color.black,
textColor: Color.white,
buttonColor: Color.gray,
buttonTextColor: Color.black
)
static let blue = Theme(
backgroundColor: Color.blue.opacity(0.1),
textColor: Color.blue,
buttonColor: Color.blue,
buttonTextColor: Color.white
)
}

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
