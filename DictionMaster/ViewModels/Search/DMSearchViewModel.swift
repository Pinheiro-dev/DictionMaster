//
//  DMSearchViewModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation


protocol DMSearchViewModelDelegate: AnyObject {
    func fetchSearch(with word: String)
    func setDelegate(_ delegate: DMSearchViewControllerDelegate?)
}

final class DMSearchViewModel: DMSearchViewModelDelegate {
    public weak var delegate: DMSearchViewControllerDelegate?
    
    private let api: DMServiceManagerProtocol = DMServiceManager()
    var onError: ((String) -> Void)?
    
    //MARK: - Actions
    
    func fetchSearch(with word: String) {
        api.getDictionayWord(param: word) { [weak self] result in
            guard let self = self else { return}
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.delegate?.didSearch(with: model)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
    }
    
    func setDelegate(_ delegate: DMSearchViewControllerDelegate?) {
        self.delegate = delegate
    }
}
