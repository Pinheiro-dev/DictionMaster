//
//  DMSearchViewController.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//

import UIKit

final class DMSearchViewController: UIViewController {

    private let customView = DMSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        setupView()
        addConstraints()
        bind()
    }
        
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.customView.bottomButtonConstraint.constant = -(keyboardSize.height + 20)
        }
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
        customView.textField.becomeFirstResponder()
        customView.textField.delegate = self
        
        customView.searchButton.addTarget(self, 
                                          action: #selector(onClick(_:)),
                                          for: .touchUpInside)
    }
    
    private func search(word: String) {
        customView.spinner.startAnimating()
        customView.searchButton.enable(false)
        print("didSearch")
    }
    
}

//MARK: - TextFieldDelegate

extension DMSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let word = textField.text, !word.isEmpty else { return true}
        self.search(word: word)
        return true;
    }
}
