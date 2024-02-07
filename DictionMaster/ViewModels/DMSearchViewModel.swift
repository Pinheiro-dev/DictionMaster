//
//  DMSearchViewModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation


protocol DMSearchViewModelDelegate: AnyObject {
    func didSearchWord(result: String)
//    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
//    func didSelectCharacter(_ character: RMCharacter)
}

final class DMSearchViewModel: NSObject {
    public weak var delegate: DMSearchViewModelDelegate?
}
