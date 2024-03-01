//
//  DMUserDefaultsManager.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation

final class DMUserDefaultsManager {
    static let shared = DMUserDefaultsManager()
    private var userDefaults = UserDefaults.standard
    private let currentDate: Date
    private let keys = Localized().userDefaults
    
    //MARK: - init
    private init() {
        self.currentDate = Date()
    }
    
    public func isValidSearh(with string: String) -> Bool {
        guard let dateObject = userDefaults.object(forKey: keys.DATE) else {
            setDate()
            return true
        }
        
        let date = dateObject as! Date
        let day = date.get(.day)
        let month = date.get(.month)
        
        let currentDay = currentDate.get(.day)
        let currentMonth = currentDate.get(.month)
        
        if !((day == currentDay) && (month == currentMonth)) {
            self.resetUserDefaults()
        }
        
        if (userDefaults.object(forKey: string.uppercased()) == nil) {
            let count = userDefaults.integer(forKey: keys.COUNT_SEARCH)
            if (count > 4) {
                return false
            }
        }
        
        return true
    }
    
    public func configSearch(word: String) {
        if userDefaults.object(forKey: keys.COUNT_SEARCH) == nil {
            setCountSearch()
        }
        self.addCountSearch()
        self.setWord(word.uppercased())
    }
    
    //MARK: - private funcs

    private func setDate(){
        userDefaults.set(currentDate, forKey: keys.DATE)
        userDefaults.synchronize()
    }
    
    private func setCountSearch(){
        userDefaults.set(0, forKey: keys.COUNT_SEARCH)
        userDefaults.synchronize()
    }
    
    private func setWord(_ word: String){
        userDefaults.set(word, forKey: word.uppercased())
        userDefaults.synchronize()
    }
    
    private func addCountSearch() {
        let count = userDefaults.integer(forKey: keys.COUNT_SEARCH)
        userDefaults.set(count+1, forKey: keys.COUNT_SEARCH)
        userDefaults.synchronize()
    }
    
    private func resetUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
        userDefaults.synchronize()
        self.setDate()
        self.setCountSearch()
    }
    
}

