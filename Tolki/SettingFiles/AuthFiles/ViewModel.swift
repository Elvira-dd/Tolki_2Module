import Foundation

// MARK: - Data Model

enum Signup {
    struct Request: Encodable {
        var user: UserData

        struct UserData: Encodable {
            var email: String
            var password: String
            var passwordConfirmation: String

            enum CodingKeys: String, CodingKey {
                case email
                case password
                case passwordConfirmation = "password_confirmation"
            }
        }
    }

    struct Response: Decodable {
        let messages: String
        let isSuccess: Bool
        let jwt: String

        enum CodingKeys: String, CodingKey {
            case messages
            case isSuccess = "is_success"
            case jwt
        }
    }
}

enum Signin {
    struct Request: Encodable {
        var email: String
        var password: String
    }

    struct Response: Decodable {
        let messages: String
        let isSuccess: Bool
        let jwt: String

        enum CodingKeys: String, CodingKey {
            case messages
            case isSuccess = "is_success"
            case jwt
        }
    }
}

// MARK: - ViewModel
final class ViewModel: ObservableObject {
    enum Const {
        static let tokenKey = "token"
    }

    @Published var username: String = ""
    @Published var gotToken: Bool = false
    @Published var currentProfile: UserProfile?
    @Published var profileError: String?

    private var worker = AuthWorker()
    private var keychain = KeychainService()

    // MARK: - Auth Methods
    func signUp(
        email: String,
        password: String,
        passwordConfirmation: String
    ) {
        let endpoint = AuthEndpoint.signup
        let userData = Signup.Request.UserData(
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation
        )
        let requestData = Signup.Request(user: userData)

        let body = try? JSONEncoder().encode(requestData)
        if let body = body {
            let jsonString = String(data: body, encoding: .utf8) ?? "Invalid JSON"
            print("Request JSON: \(jsonString)")
        }

        let request = Request(endpoint: endpoint, method: .post, body: body)
        print("Sending request to: \(worker.worker.baseUrl)\(endpoint.compositePath)")
        worker.load(request: request) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                if let data {
                    let jsonString = String(data: data, encoding: .utf8) ?? "Invalid data"
                    print("Received JSON: \(jsonString)")
                    if let response = try? JSONDecoder().decode(Signup.Response.self, from: data) {
                        let token = response.jwt
                        print("Decoded token: \(token)")
                        self?.keychain.setString(token, forKey: Const.tokenKey)
                        DispatchQueue.main.async {
                            self?.gotToken = true
                        }
                    } else {
                        print("Failed to decode token")
                    }
                } else {
                    print("No data received")
                }
            }
        }
    }
    
    func signIn(
        email: String,
        password: String
    ) {
        let endpoint = AuthEndpoint.signin
        let requestData = Signin.Request(
            email: email,
            password: password
        )
        let body = try? JSONEncoder().encode(requestData)
        let request = Request(endpoint: endpoint, method: .post, body: body)
        
        print("Sending request to: \(worker.worker.baseUrl)\(endpoint.compositePath)")
        worker.load(request: request) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                if let data {
                    let jsonString = String(data: data, encoding: .utf8) ?? "Invalid data"
                    print("Received JSON: \(jsonString)")
                    if let response = try? JSONDecoder().decode(Signin.Response.self, from: data) {
                        let token = response.jwt
                        print("Decoded token: \(token)")
                        self?.keychain.setString(token, forKey: Const.tokenKey)
                        DispatchQueue.main.async {
                            self?.gotToken = true
                            self?.fetchCurrentProfile() // Загружаем профиль после успешного входа
                        }
                    } else {
                        print("Failed to decode token")
                    }
                } else {
                    print("No data received")
                }
            }
        }
    }

    // MARK: - Profile Methods
    func fetchCurrentProfile() {
        let token = keychain.getString(forKey: Const.tokenKey) ?? ""
        guard !token.isEmpty else {
            profileError = "Токен авторизации не найден"
            return
        }
        
        let request = Request(
            endpoint: AuthEndpoint.profile,
            method: .get,
            headers: ["Authorization": "Bearer \(token)"]
        )
        
        worker.load(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data = data else {
                        self?.profileError = "Нет данных в ответе"
                        return
                    }
                    
                    do {
                        let profile = try JSONDecoder().decode(UserProfile.self, from: data)
                        self?.currentProfile = profile
                        self?.profileError = nil
                    } catch {
                        print("Ошибка декодирования профиля: \(error)")
                        self?.profileError = "Ошибка обработки данных профиля"
                    }
                    
                case .failure(let error):
                    self?.profileError = error.localizedDescription
                }
            }
        }
    }

    // MARK: - Other Methods
    func getUsers() {
        let token = keychain.getString(forKey: Const.tokenKey) ?? ""
        let request = Request(endpoint: AuthEndpoint.users(token: token))
        print("Sending request to: \(worker.worker.baseUrl)\(request.endpoint.compositePath)")
        worker.load(request: request) { result in
            switch result {
            case .failure(_):
                print("error")
            case .success(let data):
                guard let data else {
                    print("error")
                    return
                }
                print(String(data: data, encoding: .utf8))
            }
        }
    }
}

// MARK: - Networking
enum AuthEndpoint: Endpoint {
    case signup
    case signin
    case users(token: String)
    case profile
    
    var rawValue: String {
        switch self {
        case .signup: return "sign_up"
        case .signin: return "sign_in"
        case .users: return "posts"
        case .profile: return "users/me"
        }
    }
    
    var compositePath: String {
        return "/api/v1/\(self.rawValue)"
    }
    
    var headers: [String: String] {
        switch self {
        case .users(let token): return ["Authorization": "Bearer \(token)"]
        default: return [:]
        }
    }
}

final class AuthWorker {
    let worker = BaseURLWorker(baseUrl: "http://127.0.0.1:3000")
    
    func load(request: Request, completion: @escaping (Result<Data?, Error>) -> Void) {
        // Создаем URLRequest
        let url = URL(string: worker.baseUrl + request.endpoint.compositePath)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        // Добавляем headers если они есть
        request.headers?.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        // Добавляем стандартные headers из endpoint
        request.endpoint.headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        // Выполняем запрос
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
