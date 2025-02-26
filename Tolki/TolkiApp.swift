//
//  TolkiApp.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

@main
struct TolkiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
    
}

