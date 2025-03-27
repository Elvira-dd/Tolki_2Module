//
//  IssueDateilView.swift
//  Cry
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI

struct IssueDetailView: View {
var issue: Issue

var body: some View {
    ScrollView {
        VStack(alignment: .leading, spacing: 16) {
            Text(issue.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(issue.description)
                .font(.body)
            
            Text("Подкаст ID: \(issue.podcastId)")
                .font(.subheadline)
            
            Text("Дата создания: \(issue.createdAt)")
                .font(.subheadline)
            
            AsyncImage(url: URL(string: issue.coverURL)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } placeholder: {
                ProgressView()
            }
            
            // Раздел для комментариев
            VStack(alignment: .leading) {
                Text("Комментарии:")
                    .font(.headline)
                ForEach(issue.comments) { comment in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("User \(comment.userId):")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(comment.content)
                            .font(.body)
                            .padding(.bottom, 10)
                    }
                }
            }
            .padding(.top)
        }
        .padding()
    }
    .navigationTitle("Выпуск")
}
}

#Preview {
    PodcastView()
       
}
