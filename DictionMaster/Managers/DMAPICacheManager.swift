//
//  DMAPICacheManager.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation

final class DMAPICacheManager {
    static let shared = DMAPICacheManager()
    private var apiDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func cachedResponse(for url: URL?) -> Data? {
        guard let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return apiDataCache.object(forKey: key) as? Data
    }
    
    public func setCache(for url: URL?, data: Data) {
        print("Teste1: ", url)
        guard let url = url else {
            return
        }
        
        let key = url.absoluteString as NSString
        let value = data as NSData
        self.apiDataCache.setObject(value, forKey: key)
    }
}
