//
//  DMServiceManager.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

protocol DMServiceManagerProtocol: AnyObject {
    func getDictionayWord(param: String,
                          completion: @escaping (Result<[DictionaryModel], Error>) -> Void)
}

final class DMServiceManager: DMServiceManagerProtocol {
    
    func getDictionayWord(param: String,
                          completion: @escaping (Result<[DictionaryModel], Error>) -> Void) {
        let request = DMRequest(endpoint: .entries, param: param)
        DMService.shared.execute(request) { (result: Result<[DictionaryModel], Error>) in
            switch result {
            case .success(let responseModel):
                completion(.success(responseModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
