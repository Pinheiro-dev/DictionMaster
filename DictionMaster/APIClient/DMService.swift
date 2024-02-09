//
//  DMService.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

enum DMServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
    case failedToGetDataCached
    case failedToGetResponse
    case searchLimitExceeded
    case notFoundWith(error: ErrorNotFoundModel?)
}

/// Primary API service object to get Diction Master data.
final class DMService {
    /// Shared singleton instace
    static let shared = DMService()

    private let cacheManager = DMAPICacheManager.shared
    private let userDefaults = DMUserDefaultsManager.shared

    private init() {}

    /// Send Diction Master API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute<T: Decodable>(_ request: DMRequest,
                                      completion: @escaping ((Result<T, Error>) -> Void)) {
        
        if let cachedData = cacheManager.cachedResponse(for: request.url) {
            do {
                let result = try JSONDecoder().decode(T.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(DMServiceError.failedToGetDataCached))
            }
            return
        }
        
        if (!self.userDefaults.isValidSearh(with: request.param)) {
            completion(.failure(DMServiceError.searchLimitExceeded))
            return
        }

        guard let urlRequest = self.request(from: request) else {
            completion(.failure(DMServiceError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? DMServiceError.failedToGetData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DMServiceError.failedToGetResponse))
                return
            }
            
            if response.statusCode == 404 {
                do {
                    let result = try JSONDecoder().decode(ErrorNotFoundModel.self, from: data)
                    completion(.failure(DMServiceError.notFoundWith(error: result)))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            }

            //Decode response
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                self?.cacheManager.setCache(for: request.url, data: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()

    }
    
    /// Get audio content with URL
    /// - Parameters:
    ///   - url: Source url
    ///   - completion: Callback
    public func downloadAudio(_ url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { URL, _, error in
            guard let URL = URL, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }

            completion(.success(URL))
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
