import Foundation

// For dependency injections and custom networkers
// Example: Service that allows switching to testing environments
protocol NetworkingLogic {
    typealias Response = ((_ response: Result<Networking.ServerResponse, Error>) -> Void)

    func executeRequest(with request: Request, completion: @escaping Response)
}

enum Networking {
    struct ServerResponse {
        var data: Data?
        var response: URLResponse?
    }

    enum Error: Swift.Error {
        case emptyData
        case invalidRequest
    }
}

final class BaseURLWorker: NetworkingLogic {
    var baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func executeRequest(with request: Request, completion: @escaping Response) {
        guard let urlRequest = convert(request) else {
            completion(.failure(Networking.Error.invalidRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(Networking.ServerResponse(data: data, response: response)))
        }

        task.resume()
    }

    private func convert(_ request: Request) -> URLRequest? {
        guard let url = generateDestinationURL(for: request) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.endpoint.headers
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = request.timeoutInterval

        return urlRequest
    }

    private func generateDestinationURL(for request: Request) -> URL? {
        guard
            let url = URL(string: baseUrl),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            return nil
        }

        let queryItems = request.parameters?.map {
            URLQueryItem(name: $0, value: $1)
        }

        components.path += request.endpoint.compositePath
        components.queryItems = queryItems

        return components.url
    }
}
