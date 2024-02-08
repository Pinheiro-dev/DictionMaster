//
//  DMRequest.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

/// Object that represents a single API call
final class DMRequest {

    /// API Constants
    private struct Constants {
        static let baseURL = "https://api.dictionaryapi.dev"
    }

    /// Desired endpoint
    let endpoint: DMEndpoint
    /// Param for API, if any
    private let param: String?
    
    private let urlParm: String?

    /// Constructed url fot the api request in string format
    private var urlString: String {
        guard let param = param else {
            return urlParm!
        }
        
        var string = Constants.baseURL
        switch endpoint {
            default:
                string += "/api/v2/entries/en/\(param)"
        }

        return string
    }

    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public var httpMethod: HttpMethod = .get
 
    // MARK: - init

    /// Constructor request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - param: Parameter to send
    ///   - method: Method to call
    ///   - url: URL to call service without endpoint and param
    init(endpoint: DMEndpoint,
         param: String? = nil,
         method: HttpMethod = .get,
         _ url: String? = nil) {
        self.endpoint = endpoint
        self.param = param
        self.httpMethod = method
        self.urlParm = url
    }
}

extension DMRequest {
    enum HttpMethod: String {
        case get = "GET"
    }
}
