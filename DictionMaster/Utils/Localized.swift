//
//  Localized.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 09/02/24.
//

import Foundation

struct Localized {
    //MARK: - SearchString
    enum SearchString {
        static let typeAWord = String(localized: "type_a_word")
        static let search = String(localized: "search")
        static let english = String(localized: "english")
    }
    
    //MARK: - SearchResultString
    enum SearchResultString {
        static let tryAnotherSearch = String(localized: "try_another_search")
        static let newSearch = String(localized: "new_search")
        static func thatsIt(with word: String) -> String {
            return String.localizedStringWithFormat(String(localized: "thats_it"), word)
        }
    }
    
    //MARK: - PurchaseString
    enum PurchaseString {
        static let limitExceeded = String(localized: "search_limit_exceeded")
        static let unlimited = String(localized: "unlimited")
        static let allFeatures = String(localized: "all_features")
        static let pricePurchaseLabel = String(localized: "price_purchase_label")
        static let trySevenDays = String(localized: "try_7_days_free")
        static let pricePurchaseValue = String(localized: "price_purchase_value")
        static let subscribe = String(localized: "subscribe")
    }
    
    //MARK: - ErrorString
    enum ErrorString {
        static let genericTitleSearch = String(localized: "generic_title_error_search")
        static let genericMessageSearch = String(localized: "generic_message_error_search")
        static let genericTitleAudio = String(localized: "generic_title_error_audio")
        static let genericMessage = String(localized: "generic_message")
    }
    
    //MARK: - Cache
    enum UserDefaultsKeys {
        static let DATE = "DATE"
        static let COUNT_SEARCH = "COUNT_SEARCH"
    }
    
}
