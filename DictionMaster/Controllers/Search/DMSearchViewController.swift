//
//  DMSearchViewController.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//
import Foundation
import UIKit

protocol DMSearchViewControllerDelegate: AnyObject {
    func didSearch(with dictionary: [DictionaryModel])
    func didSearchFailed(errorTitle: String, errorMessage: String)
    func goToPurchase()
}

final class DMSearchViewController: UIViewController {
    private let customView = DMSearchView()
    private let viewModel: DMSearchViewModelDelegate = DMSearchViewModel()
    private var buttomConstant: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        viewModel.setDelegate(self)
        setupView()
        addConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
        
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let constant = self.buttomConstant else {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.buttomConstant = -(keyboardSize.height + 20)
                self.customView.bottomButtonConstraint.constant = -(keyboardSize.height + 20)
            }
            return
        }
        self.buttomConstant = constant
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let isEmpty = textField.text?.isEmpty else {
            return self.customView.searchButton.isHidden = true
        }
        
        if isEmpty {
            self.customView.searchButton.isHidden = true
        } else {
            self.customView.searchButton.isHidden = false
        }
    }
    
    @objc private func onClick(_ sender: UIButton) {
        guard let word = self.customView.textField.text else { return }
        self.search(word: word)
    }

    private func setupView() {
        view.addSubview(customView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bind() {
        customView.textField.addTarget(self,
                                       action: #selector(textFieldDidChange(_:)),
                                       for: .editingChanged)
        customView.textField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(onClick(_:)))
        customView.searchButton.addGestureRecognizer(gesture)
    }
    
    private func finishSearch() {
        customView.searchButton.setLoading(true)
        customView.textField.text = ""
        textFieldDidChange(customView.textField)
    }
    
    private func search(word: String) {
        customView.searchButton.setLoading(false)
        self.viewModel.fetchSearch(with: word)
    }
    
}

//MARK: - TextFieldDelegate

extension DMSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let word = textField.text,
              !word.isEmpty,
              customView.searchButton.isUserInteractionEnabled else {
            return true
        }
        
        self.customView.searchButton.setLoading(false)
        self.search(word: word)
        return true;
    }
}

//MARK: - SearchViewController Delegate

extension DMSearchViewController: DMSearchViewControllerDelegate {
    func didSearchFailed(errorTitle: String, errorMessage: String) {
        self.finishSearch()
        self.showAlertMessage(title: errorTitle, message: errorMessage)
    }
    
    func didSearch(with dictionary: [DictionaryModel]) {
        customView.textField.resignFirstResponder()
        self.finishSearch()
        let vc = DMSearchResultViewController(dictionary: dictionary)
        vc.navigationItem.hidesBackButton = true
        self.navigationController?.push(viewController: vc)
    }
    
    func goToPurchase() {
        customView.textField.resignFirstResponder()
        self.finishSearch()
        let vc = DMPurchaseViewController()
        vc.navigationItem.hidesBackButton = true
        self.navigationController?.push(viewController: vc)
    }
}
