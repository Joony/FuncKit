import Foundation

public struct JSONREST {
    
    /**
     Conveniently create a JSON GET request.
     
     - parameter resource: A URL string.
     
     - returns: A Request containing a new NSURLRequest.
     */
    public static func createJSONGetRequest(url: URL) -> URLRequest {
        let f = REST.createGetRequest(url:) >>> self.addJSONHeader(toRequest:)
        return f(url)
    }
    
    /**
     Conveniently create a JSON POST request.
     
     - parameter resource: A URL string.
     
     - returns: A Request containing a new NSURLRequest.
     */
    public static func createJSONPostRequest(url: URL) -> URLRequest {
        let f = REST.createPostRequest(url:) >>> self.addJSONHeader(toRequest:)
        return f(url)
    }
    
    /**
     Conveniently create a JSON PUT request.
     
     - parameter resource: A URL string.
     
     - returns: A Request containing a new NSURLRequest.
     */
    public static func createJSONPutRequest(url: URL) -> URLRequest {
        let f = REST.createPutRequest(url:) >>> self.addJSONHeader(toRequest:)
        return f(url)
    }
    
    public static func createJSONDeleteRequest(url: URL) -> URLRequest {
        let f = REST.createDeleteRequest(url:) >>> self.addJSONHeader(toRequest:)
        return f(url)
    }
    
    public static func createJSONPatchRequest(url: URL) -> URLRequest {
        let f = REST.createPatchRequest(url:) >>> self.addJSONHeader(toRequest:)
        return f(url)
    }
    
    /**
     Adds JSON Content-Type and Accept headers to an NSURLRequest.
     
     - returns: A Result containing a new NSURLRequest.
     */
    public static func addJSONHeader(toRequest request: URLRequest) -> URLRequest {
        return REST.add(headerFields: ["Content-Type": "application/json", "Accept": "application/json"], toRequest: request)
    }
    
    
    /**
     Add JSON as the body of an NSURLRequest.
     
     - parameter body: A collection of data to convert to JSON.
     
     - returns: A Result containing a new NSURLRequest or Result.Failure(error) containing an error that occured during JSON deserialization.
     */
    public static func addJSONBodyToRequest(body: [[String: Any]], toRequest request: URLRequest) -> Result<URLRequest> {
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: [])
            return .success(REST.add(body: data, toRequest: request))
        } catch let e {
            return .failure(e)
        }
    }
    public static func addJSONBodyToRequest(body: [String: Any], toRequest request: URLRequest) -> Result<URLRequest> {
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: [])
            return .success(REST.add(body: data, toRequest: request))
        } catch let e {
            return .failure(e)
        }
    }
    
    // MARK: - Transformations
    
    //    var transformToJSONArray: (result: RESTResultDTO) -> Result<[[String: AnyObject]]> {
    //        return transformRESTResultDTOToData >=> self.transformDataToJSONArray
    //    }
    
    /**
     Convert NSData (of a JSON Array of Dictionaries) to a native collection.
     
     - parameter data: NSData containing the raw JSON.
     
     - returns: A result containing a raw collection or one of two errors: RESTDAOError.TransformationUnableToCast, or RESTDAOError.Error(error) containing an error that occured during JSON deserialization.
     */
    public static func transformDataToJSONArray(data: Data) -> Result<[[String: AnyObject]]> {
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                return .success(jsonArray)
            }
        } catch let error {
            return .failure(REST.RESTError.error(error))
        }
        return .failure(REST.RESTError.transformationUnableToCast)
    }
    
    public static func transformDataToJSONDictionary(data: Data) -> Result<[String: AnyObject]> {
        do {
            if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                return .success(jsonDictionary)
            }
        } catch let error {
            return .failure(REST.RESTError.error(error))
        }
        return .failure(REST.RESTError.transformationUnableToCast)
    }
    
    public static func decode<T>(type: T.Type, from data: Data) -> Result<T> where T: Decodable {
        do {
            let dto = try JSONDecoder().decode(type, from: data)
            return .success(dto)
        } catch let error {
            return .failure(REST.RESTError.error(error))
        }
    }
    
    public static func validateJSONDictionary(result: REST.ResultDTO) -> Result<[String: AnyObject]> {
        let f =
            REST.validate(response:) >=>
            REST.transformResultDTOToData >=>
            self.transformDataToJSONDictionary(data:)
        return f(result)
    }
    
    public static func validateJSONArray(result: REST.ResultDTO) -> Result<[[String: AnyObject]]> {
        let f =
            REST.validate(response:) >=>
            REST.transformResultDTOToData >=>
            self.transformDataToJSONArray(data:)
        return f(result)
    }
    
}
