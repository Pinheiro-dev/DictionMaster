//
//  DMContentService.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

protocol DMContentServiceProtocol: AnyObject {
    func getDictionayWord(param: String,
                          completion: @escaping (Result<[DictionaryModel], Error>) -> Void)
    func downloadAudio(with url: URL,
                       completion: @escaping (Result<URL, Error>) -> Void)
}

final class DMContentService: DMContentServiceProtocol {
    
    func getDictionayWord(param: String,
                          completion: @escaping (Result<[DictionaryModel], Error>) -> Void) {
        let request = DMRequest(endpoint: .entries, param: param.lowercased())
        DMService.shared.execute(request) { (result: Result<[DictionaryModel], Error>) in
            switch result {
            case .success(let responseModel):
                completion(.success(responseModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func downloadAudio(with url: URL,
                       completion: @escaping (Result<URL, Error>) -> Void) {
        DMService.shared.downloadAudio(url) { (result: Result<URL, Error>) in
            switch result {
            case .success(let url):
                completion(.success(url))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
