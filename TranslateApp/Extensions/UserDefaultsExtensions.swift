//
//  UserDefaultsExtensions.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 10.03.2022.
//

import Foundation


extension UserDefaults {
    var savedList: [Translate] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "savedList") else { return [] }
            return (try? PropertyListDecoder().decode([Translate].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "savedList")
        }
    }
    var historyList: [Translate] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "historyList") else { return [] }
            return (try? PropertyListDecoder().decode([Translate].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "historyList")
        }
    }
}
