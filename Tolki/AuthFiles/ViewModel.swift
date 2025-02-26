import Foundation

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

final class ViewModel: ObservableObject {
    enum Const {
        static let tokenKey = "token"
    }

    @Published var username: String = ""
    @Published var gotToken: Bool = KeychainService().getString(forKey: Const.tokenKey)?.isEmpty == false

    private var worker = AuthWorker()
    private var keychain = KeychainService()

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

        enum AuthEndpoint: Endpoint {
            case signup
            case signin
            case users(token: String)

            var rawValue: String {
                switch self {
                case .signup:
                    return "sign_up"
                case .signin:
                    return "sign_in"
                case .users:
                    return "posts"
                }
            }

            var compositePath: String {
                return "/api/v1/\(self.rawValue)"
            }

            var headers: [String: String] {
                switch self {
                case .users(let token): ["Authorization": "Bearer \(token)"]
                default: ["Content-Type": "application/json"]
                }
            }
        }

        final class AuthWorker {
            let worker = BaseURLWorker(baseUrl: "http://127.0.0.1:3000")

            func load(request: Request, completion: @escaping (Result<Data?, Error>) -> Void) {
                worker.executeRequest(with: request) { response in
                    switch response {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let result):
                        completion(.success(result.data))
                    }
                }
            }
        }

