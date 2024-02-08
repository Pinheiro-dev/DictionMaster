//
//  DMService.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

/// Primary API service object to get Diction Master data.
final class DMService {
    /// Shared singleton instace
    static let shared = DMService()

//    private let cacheManager = DMAPICacheManager()

    private init() {}

    enum DMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    /// Send Diction Master API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute<T: Decodable>(_ request: DMRequest,
                                      completion: @escaping ((Result<T, Error>) -> Void)) {

//        if let cachedData = cacheManager.cachedResponse(for: request.endpoint,
//                                                        url: request.url) {
//            do {
//                let result = try JSONDecoder().decode(T.self, from: cachedData)
//                completion(.success(result))
//            } catch {
//                completion(.failure(error))
//            }
//            return
//        }

        guard let urlRequest = self.request(from: request) else {
            completion(.failure(DMServiceError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? DMServiceError.failedToGetData))
                return
            }

            //Decode response
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
//                self?.cacheManager.setCache(for: request.endpoint,
//                                            url: request.url,
//                                            data: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()

    }

    // MARK: - Private
    private func request(from rmRequest: DMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod.rawValue

        return request
    }
}
