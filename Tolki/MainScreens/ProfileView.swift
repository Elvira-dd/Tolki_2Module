//
//  ProfileView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI
class ProfileViewModel: ObservableObject {
    @Published var currentProfile: UserProfile?
    @Published var isLoading = false
    @Published var error: String?
    
    private let keychain = KeychainService()
    
    func loadCurrentProfile() {
        isLoading = true
        error = nil
        
        let token = keychain.getString(forKey: ViewModel.Const.tokenKey) ?? ""
        
        guard !token.isEmpty else {
            error = "Токен авторизации не найден"
            isLoading = false
            return
        }
        
        ProfileService.shared.fetchCurrentProfile(authToken: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let profile):
                    self?.currentProfile = profile
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("Ошибка загрузки профиля: \(error.localizedDescription)")
                }
            }
        }
    }
}
struct ProfileView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if let profile = viewModel.currentProfile {
                Text(profile.profile.name)
                    .font(.title)
                Text(profile.email)
                Text(profile.profile.bio)
                Text("Level: \(profile.profile.level)")
            } else if let error = viewModel.profileError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.fetchCurrentProfile()
        }
    }
}
// Вспомогательные View
struct ProfileHeaderView: View {
    let profile: UserProfile
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(profile.profile.name)
                    .font(.title2.bold())
                
                Text(profile.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(error)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct AdminBadge: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.green)
            Text("Администратор")
                .font(.caption)
                .bold()
        }
        .padding(6)
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
    }
}
