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
    private init() {
        self.currentDate = Date()
    }
    
    public func isValidSearh(with string: String) -> Bool {
        guard let dateObject = userDefaults.object(forKey: "DATE") else {
            setDate()
            setCountSearch()
            setWord(string)
            return true
        }
                
        let date = dateObject as! Date
        let day = date.get(.day)
        let month = date.get(.month)
        
        let currentDay = currentDate.get(.day)
        let currentMonth = currentDate.get(.month)
        
        if ((day == currentDay) && (month == currentMonth)) {
            self.addCountSearch()
        } else {
            self.resetUserDefaults()
        }
        
        if (userDefaults.object(forKey: string.uppercased()) == nil) {
            setWord(string)
            let count = userDefaults.integer(forKey: "COUNT_SEARCH")
            return count < 5
        }
        
        return true
    }

    private func setDate(){
        userDefaults.set(currentDate, forKey: "DATE")
    }
    
    private func setCountSearch(){
        userDefaults.set(0, forKey: "COUNT_SEARCH")
    }
    
    private func setWord(_ word: String){
        userDefaults.set(word, forKey: "\(word.uppercased())")
    }
    
    private func addCountSearch() {
        let count = userDefaults.integer(forKey: "COUNT_SEARCH")
        userDefaults.set(count+1, forKey: "COUNT_SEARCH")
    }
    
    private func resetUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
        self.setDate()
        self.setCountSearch()
        userDefaults.synchronize()
    }
    
}

