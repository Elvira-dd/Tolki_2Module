//
//  AboutView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("About This App")
                    .font(.title)
                    .padding()
                
                Text("This is a sample app to demonstrate SwiftUI and customization.")
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle("About", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
}
