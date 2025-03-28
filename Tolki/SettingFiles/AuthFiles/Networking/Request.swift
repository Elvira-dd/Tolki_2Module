import Foundation

// MARK: - Request Structure (updated)
struct Request {
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case options = "OPTIONS"
    }

    var endpoint: Endpoint
    var method: RequestMethod
    var parameters: [String: String]?
    var body: Data?
    var headers: [String: String]?  // Изменили на var
    var timeoutInterval: TimeInterval

    init(
        endpoint: Endpoint,
        method: RequestMethod = .get,
        parameters: [String: String]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil,
        timeoutInterval: TimeInterval = 60
    ) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.body = body
        self.headers = headers
        self.timeoutInterval = timeoutInterval

        if var endpointParameters = endpoint.parameters {
            for (key, value) in parameters ?? [:] {
                endpointParameters[key] = value
            }
            self.parameters = endpointParameters
        }
    }
}
