//
//  DMSearchViewModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation


protocol DMSearchViewModelDelegate: AnyObject {
    func didSearchWord(result: String)
}

final class DMSearchViewModel: NSObject {
    public weak var delegate: DMSearchViewModelDelegate?
}
