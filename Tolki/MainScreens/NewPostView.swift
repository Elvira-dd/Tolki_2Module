import SwiftUI

struct CreatePostView: View {
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var link: String = ""
    @State private var hashtag: String = ""
    @State private var isCommentsOpen: Bool = true

    @State private var isLoading: Bool = false
    @State private var isSuccess: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            Text("Создать новый пост")
                .font(.largeTitle)
                .padding()

            Form {
                Section(header: Text("Данные поста")) {
                    TextField("Название поста", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Контент", text: $content)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Ссылка", text: $link)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Хештег", text: $hashtag)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Toggle(isOn: $isCommentsOpen) {
                        Text("Открыть комментарии")
                    }
                }
                
                Section {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Button("Создать пост") {
                            submitPost()  // Изменили имя метода на submitPost
                        }
                    }
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            if isSuccess {
                Text("Пост успешно создан!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }

    // Изменили имя метода на submitPost
    private func submitPost() {
        let newPost = Posts(
            id: nil,  // Сервер сам сгенерирует id
            title: title,
            content: content,
            isCommentsOpen: isCommentsOpen,
            link: link,
            hashtag: hashtag,
            createdAt: ISO8601DateFormatter().string(from: Date()),
            comments: nil
        )

        isLoading = true
        errorMessage = nil

        // Вызов функции для отправки поста на сервер
        createPost(post: newPost) { result in  // Эта строка не изменилась
            isLoading = false
            switch result {
            case .success(_):
                isSuccess = true
            case .failure(let error):
                errorMessage = "Ошибка при создании поста: \(error.localizedDescription)"
            }
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}


import Foundation

func createPost(post: Posts, completion: @escaping (Result<Posts, Error>) -> Void) {
    guard let url = URL(string: "https://your-api-url.com/posts") else {
        return completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // Кодируем данные в JSON
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(post)
        request.httpBody = data
    } catch {
        return completion(.failure(error))
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            return completion(.failure(error))
        }

        if let data = data {
            do {
                let decoder = JSONDecoder()
                let newPost = try decoder.decode(Posts.self, from: data)
                completion(.success(newPost))
            } catch {
                completion(.failure(error))
            }
        }
    }

    task.resume()
}
