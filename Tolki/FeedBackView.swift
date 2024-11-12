//
//  FeedBackView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//
import SwiftUI

struct FeedbackView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("We value your feedback!")
                    .font(.title)
                    .padding()
                Text("Please let us know your thoughts and suggestions to improve the app.")
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Feedback", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                UIApplication.shared.windows
                    .first?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
}
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
                UIApplication.shared.windows
                    .first?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
}
