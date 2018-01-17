import Foundation

extension Result {
    
    public var failureValue: Error? {
        guard case let .failure(error) = self else {
            return nil
        }
        return error
    }
    
    public var successValue: Wrapped? {
        guard case let .success(value) = self else {
            return nil
        }
        return value
    }
    
}
