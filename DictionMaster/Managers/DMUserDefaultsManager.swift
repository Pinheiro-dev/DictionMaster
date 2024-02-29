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
            setCountSearch()
            setWord(string)
            return true
        }
        
        let count = userDefaults.integer(forKey: keys.COUNT_SEARCH)
        let date = dateObject as! Date
        let day = date.get(.day)
        let month = date.get(.month)
        
        let currentDay = currentDate.get(.day)
        let currentMonth = currentDate.get(.month)
        
        if ((day == currentDay) && (month == currentMonth)) {
            if (count < 5) {
                self.addCountSearch()
            }
        } else {
            self.resetUserDefaults()
        }
        
        if (count >= 5) {
            return false
        }
        
        if (userDefaults.object(forKey: string.uppercased()) == nil) {
            setWord(string)
            return count <= 5
        }
        
        return true
    }
    
    //MARK: - private funcs

    private func setDate(){
        userDefaults.set(currentDate, forKey: keys.DATE)
        userDefaults.synchronize()
    }
    
    private func setCountSearch(){
        userDefaults.set(1, forKey: keys.COUNT_SEARCH)
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

