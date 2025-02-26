import Foundation

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
    let body: Data?
    var timeoutInterval: TimeInterval

    init(
        endpoint: Endpoint,
        method: Request.RequestMethod = .get,
        parameters: [String: String]? = nil,
        body: Data? = nil,
        timeoutInterval: TimeInterval = 60
    ) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.body = body
        self.timeoutInterval = timeoutInterval

        if var endpointParameters = endpoint.parameters {
            for (key, value) in parameters ?? [:] {
                endpointParameters[key] = value
            }

            self.parameters = endpointParameters
        }
    }
}
