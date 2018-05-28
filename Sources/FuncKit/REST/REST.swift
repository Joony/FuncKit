import UIKit

public struct REST {
    
    enum RESTResource: String {
        case Root = ""
    }
    
    public enum RESTError: Error {
        case error(Error)
        case invalidResource
        case noResponse
        case transformation(Error)
        case transformationUnableToCast
        case clientError(statusCode: Int, data: Data?)
        case serverError(Int)
        case noData
        case noInternet
        case hostnameNotFound
        case requestTimedOut
    }
    
    public enum Method: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case PATCH = "PATCH"
        case DELETE = "DELETE"
    }
    
    public struct ResultDTO {
        public let data: Data?
        public let response: HTTPURLResponse?
        public let error: URLError?
        init(data: Data?, response: HTTPURLResponse?, error: URLError?) {
            self.data = data
            self.response = response
            self.error = error
        }
    }
    
    // MARK: - Requests
    
    // MARK: GET
    
    /**
     Create a GET request.
     
     - parameter resource: A URL string.
     
     - returns: A Result containing a new NSURLRequest.
     */
    public static func createGetRequest(url: URL) -> URLRequest {
        let f = createRequest(url:) >>> papply(REST.Method.GET, f: add(method:toRequest:))
        return f(url)
    }
    
    // MARK: POST
    
    /**
     Create a POST request.
     
     - parameter resource: A URL string.
     
     - returns: A Result containing a new NSURLRequest.
     */
    public static func createPostRequest(url: URL) -> URLRequest {
        let f = createRequest(url:) >>> papply(REST.Method.POST, f: add(method:toRequest:))
        return f(url)
    }
    
    // MARK: PUT
    
    /**
     Create a PUT request.
     
     - parameter resource: A URL string.
     
     - returns: A Result containing a new NSURLRequest.
     */
    public static func createPutRequest(url: URL) -> URLRequest {
        let f = createRequest(url:) >>> papply(REST.Method.PUT, f: add(method:toRequest:))
        return f(url)
    }
    
    // MARK: PATCH
    
    /**
     Create a PATCH request.
     
     - parameter resource: A URL string.
     
     - returns: A Result containing a new NSURLRequest.
     */
    public static func createPatchRequest(url: URL) -> URLRequest {
        let f = createRequest(url:) >>> papply(REST.Method.PATCH, f: add(method:toRequest:))
        return f(url)
    }
    
    // MARK: DELETE
    
    /**
     Create a DELETE request.
     
     - parameter resource: A URL string.
     
     - returns: A Result containing a new NSURLRequest.
     */
    public static func createDeleteRequest(url: URL) -> URLRequest {
        let f = createRequest(url:) >>> papply(REST.Method.DELETE, f: add(method:toRequest:))
        return f(url)
    }
    
    // MARK: - Raw request
    
    /**
     Create a new default NSURLRequest.
     
     - parameter url: A URL.
     
     - returns: A Result with a new NSURLRequest, or RESTDAOError.InvalidResource
     */
    public static func createRequest(url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    // MARK: Method
    
    /**
     Add an HTTP Method to an NSURLRequest.  Only REST methods are supported.
     
     - parameter method: A REST.Method.
     
     - returns: A Result with a new NSURLRequest.
     */
    public static func add(method: REST.Method, toRequest request: URLRequest) -> URLRequest {
        var mutableRequest = request
        mutableRequest.httpMethod = method.rawValue
        return mutableRequest
    }
    
    // MARK: Query
    
    /**
     Add query parameters to the url of an NSURLRequest.
     
     - parameter query: The query parameters to add.
     
     - returns: A Result with a new NSURLRequest.
     */
    public static func add(query: [String: String], toRequest request: URLRequest) -> URLRequest {
        var mutableRequest = request
        let queryItems = query.map(URLQueryItem.init)
        var urlComponents = URLComponents(url: mutableRequest.url!, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = urlComponents.queryItems != nil ? urlComponents.queryItems! + queryItems : queryItems
        mutableRequest.url = urlComponents.url
        return mutableRequest
    }
    
    // MARK: Body
    
    /**
     Add a body to an NSURLRequest.
     
     - parameter body: The raw NSData to add as the body.
     
     - returns: A Result with a new NSURLRequest.
     */
    public static func add(body: Data, toRequest request: URLRequest) -> URLRequest {
        var mutableRequest = request
        mutableRequest.httpBody = body
        return mutableRequest
    }
    
    // MARK: Header
    
    /**
     Add HTTP headers to an NSURLRequest.
     
     - parameter headerFields: A dictionary containing the headers to add.
     
     - returns: A Result with a new NSURLRequest.
     */
    public static func add(headerFields: [String: String], toRequest request: URLRequest) -> URLRequest {
        var request = request
        headerFields.forEach( { request.setValue($0.1, forHTTPHeaderField: $0.0) } )
        return request
    }
    
    // MARK: Cache policy
    
    /**
     Set a cache policy for a URLRequest.
     
     - parameter cachePolicy: The new cache policy for the request.
     
     - returns: A result with the new URLRequest
     */
    public static func set(cachePolicy: NSURLRequest.CachePolicy, forRequest request: URLRequest) -> URLRequest {
        var request = request
        request.cachePolicy = cachePolicy
        return request
    }
    
    // MARK: - Task
    
    /**
     Perform a network request.  Perform will always resolve successfully.  It's up to you to inspect the REST.ResultDTO for errors.
     
     - parameter session: An NSURLSession. Defaults to sharedSession.
     
     - returns: A Future that can be used to "run" the request.
     */
    public static func perform(request: URLRequest, withSession session: URLSession) -> Future<REST.ResultDTO> {
        let promise = Promise<REST.ResultDTO>()
        session.dataTask(with: request) { (data, response, error) in
            let resultDTO = REST.ResultDTO(data: data, response: response as? HTTPURLResponse, error: error as? URLError)
            promise.resolve(value: resultDTO)
        }.resume()
        return promise
    }
    
    /**
     Perform a network request using the default shared session.
     
     - parameter request: An NSURLRequest.
     
     - returns: A Future that can be used to "run" the request.
     */
    public static func perform(request: URLRequest) -> Future<REST.ResultDTO> {
        return perform(request: request, withSession: URLSession.shared)
    }
    
    public static func loadImage(urlString: String, query: [String: String]) -> Future<UIImage> {
        let f = lift(resultToFuture: lift(optionalToResult: URL.init(string:))) >=>
            papplyr(query, f: loadImage(url:query:))
        return f(urlString)
    }
    
    public static func loadImage(url: URL, query: [String: String]) -> Future<UIImage> {
        let f = lift(toFuture: createGetRequest(url:)) >=>
            lift(toFuture: papply(query, f: add(query:toRequest:))) >=>
            perform(request:) >=>
            lift(resultToFuture: validate(response:)) >=>
            lift(resultToFuture: transformResultDTOToData) >=>
            lift(resultToFuture: transformDataToImage)
        return f(url)
    }
    
    public static func loadImage(urlString: String) -> Future<UIImage> {
        let f = lift(resultToFuture: lift(optionalToResult: URL.init(string:))) >=>
            loadImage(url:)
        return f(urlString)
    }
    
    public static func loadImage(url: URL) -> Future<UIImage> {
        let f = lift(toFuture: createGetRequest(url:)) >=>
            perform(request:) >=>
            lift(resultToFuture: validate(response:)) >=>
            lift(resultToFuture: transformResultDTOToData) >=>
            lift(resultToFuture: transformDataToImage)
        return f(url)
    }
    
    // MARK: - Transformers
    
    public static func transformResultDTOToData(result: REST.ResultDTO) -> Result<Data> {
        guard let data = result.data else {
            return .failure(RESTError.noData)
        }
        return .success(data)
    }
    
    public static func transformDataToImage(data: Data) -> Result<UIImage> {
        guard let image = UIImage(data: data) else {
            return .failure(RESTError.transformationUnableToCast)
        }
        return .success(image)
    }
    
    // MARK: - Validators
    
    public static func validate(response: REST.ResultDTO) -> Result<REST.ResultDTO> {
        let f = validateError >=>
            validateResponseObject >=>
            validateClientError >=>
            validateServerError
        return f(response)
    }
    
    static func validateError(response: REST.ResultDTO) -> Result<REST.ResultDTO> {
        guard response.error == nil else {
            return .failure(response.error!)
        }
        return .success(response)
    }
    
    static func validateResponseObject(response: REST.ResultDTO) -> Result<REST.ResultDTO> {
        guard response.response != nil else {
            return .failure(RESTError.noResponse)
        }
        return .success(response)
    }
    
    static func validateClientError(response: REST.ResultDTO) -> Result<REST.ResultDTO> {
        guard !(400...499 ~= response.response!.statusCode) else {
            return .failure(RESTError.clientError(statusCode: response.response!.statusCode, data: response.data))
        }
        return .success(response)
    }
    
    static func validateServerError(result: REST.ResultDTO) -> Result<REST.ResultDTO> {
        guard !(500...599 ~= result.response!.statusCode) else {
            return .failure(RESTError.serverError(result.response!.statusCode))
        }
        return .success(result)
    }
    
    public static func validateToVoid(response: REST.ResultDTO) -> Result<Void> {
        let f = validate(response:) >=>
            lift(toResult: { (_: REST.ResultDTO) -> Void in })
        return f(response)
    }
    
}
