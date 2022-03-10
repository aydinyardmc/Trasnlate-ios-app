//
//  Translate.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import Foundation

struct Translate: Codable, Identifiable {
    var id: String = UUID().uuidString
    var text: String?
    var translatedText: String?
    var soruce: Language?
    var target: Language?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case translatedText = "translatedText"
        case soruce = "soruce"
        case target = "target"
    }
}
