//
//  DMSearchResultViewModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

protocol DMSearchResultViewModelDelegate: AnyObject {
    func getInstance() -> NSObject
}

final class DMSearchResultViewModel: NSObject, DMSearchResultViewModelDelegate {
    
    private let result: [DictionaryModel]
    
    init(result: [DictionaryModel]) {
        self.result = result
    }
    
    func getInstance() -> NSObject {
        return self
    }
}


extension DMSearchResultViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DMSearchResultTableViewCell.cellIdentifier,
                                                       for: indexPath) as? DMSearchResultTableViewCell else {
            return UITableViewCell()
        }

//        let data = locationCellViewModels[indexPath.row]
//        cell.configure(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
