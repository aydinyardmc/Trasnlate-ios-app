//
//  DetectResponse.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 11.03.2022.
//

import Foundation

struct DetectResponse: Codable, Identifiable {
    var id: String = UUID().uuidString
    var language: String?
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
    }
}
