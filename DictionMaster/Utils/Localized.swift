//
//  Localized.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 09/02/24.
//

import Foundation

struct Localized {
    let search = SearchString()
    let searchResult = SearchResultString()
    let purchase = PurchaseString()
    let error = ErrorString()
}

//MARK: - SearchString
internal struct SearchString {
    let typeAWord = String(localized: "type_a_word")
    let search = String(localized: "search")
    let english = String(localized: "english")
}

//MARK: - SearchResultString
internal struct SearchResultString {
    let tryAnotherSearch = String(localized: "try_another_search")
    let newSearch = String(localized: "new_search")
    func thatsIt(with word: String) -> String {
        return String.localizedStringWithFormat(String(localized: "thats_it"), word)
    }
}

//MARK: - PurchaseString
internal struct PurchaseString {
    let limitExceeded = String(localized: "search_limit_exceeded")
    let unlimited = String(localized: "unlimited")
    let allFeatures = String(localized: "all_features")
    let pricePurchaseLabel = String(localized: "price_purchase_label")
    let trySevenDays = String(localized: "try_7_days_free")
    let pricePurchaseValue = String(localized: "price_purchase_value")
    let subscribe = String(localized: "subscribe")
}

//MARK: - ErrorString
internal struct ErrorString {
    let genericTitleSearch = String(localized: "generic_title_error_search")
    let genericMessageSearch = String(localized: "generic_message_error_search")
    let genericTitleAudio = String(localized: "generic_title_error_audio")
    let genericMessage = String(localized: "generic_message")
}
