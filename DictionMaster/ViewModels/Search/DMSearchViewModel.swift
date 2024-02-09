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
    private weak var delegate: DMSearchViewControllerDelegate?
    private let api: DMServiceManagerProtocol = DMServiceManager()
    private let userDefaults = DMUserDefaultsManager.shared
    
    //MARK: - Actions
    
    private func showError(with error: Error) {
        guard let error = error as? DMServiceError else {
            self.delegate?.didSearchFailed(errorTitle: Localized().error.genericTitleSearch,
                                           errorMessage: Localized().error.genericMessageSearch)
            return
        }
        
        switch error {
        case .notFoundWith(let notFoundModel):
            self.delegate?.didSearchFailed(errorTitle: notFoundModel?.title ??  Localized().error.genericTitleSearch,
                                           errorMessage: notFoundModel?.message ?? Localized().error.genericMessageSearch)
        case .searchLimitExceeded:
            self.delegate?.goToPurchase()
        default:
            self.delegate?.didSearchFailed(errorTitle:  Localized().error.genericTitleSearch,
                                           errorMessage: Localized().error.genericMessageSearch)
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
