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
    
    private func showError(with error: Error) {
        guard let error = error as? DMServiceError else {
            self.delegate?.didSearchFailed(errorTitle: "Error to get definitions",
                                           errorMessage: "Sorry pal, you can try the search again at later time.")
            return
        }
        
        switch error {
        case .notFoundWith(let notFoundModel):
            self.delegate?.didSearchFailed(errorTitle: notFoundModel?.title ?? "Error to get definitions",
                                           errorMessage: notFoundModel?.message ?? "Sorry pal, you can try the search again at later time.")
        default:
            self.delegate?.didSearchFailed(errorTitle: "Error to get definitions",
                                           errorMessage: "Sorry pal, you can try the search again at later time.")
        }
        
    }
    
    func fetchSearch(with word: String) {
        api.getDictionayWord(param: word) { [weak self] result in
            guard let self = self else { return}
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.delegate?.didSearch(with: model)
                case .failure(let error):
                    self.showError(with: error)
                }
            }
        }
    }
    
    func setDelegate(_ delegate: DMSearchViewControllerDelegate?) {
        self.delegate = delegate
    }
}
