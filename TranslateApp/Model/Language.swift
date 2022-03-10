//
//  Language.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import Foundation

struct Language: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var code: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
    }
}
