//
//  DMAudioLoaderManager.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation

final class DMAudioLoaderManager {
    static let shared = DMAudioLoaderManager()
    private var audioDataCache = NSCache<NSString, NSURL>()

    private init() {}

    /// Get audio content with URL
    /// - Parameters:
    ///   - url: Source url
    ///   - completion: Callback
    public func downloadAudio(_ url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let URL = audioDataCache.object(forKey: key) {
            completion(.success(URL as URL))
            return
        }

        let task = URLSession.shared.downloadTask(with: url) { [weak self] URL, _, error in
            guard let URL = URL, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }

            let value = URL as NSURL
            self?.audioDataCache.setObject(value, forKey: key)
            completion(.success(URL))
        }
        task.resume()
    }
}
