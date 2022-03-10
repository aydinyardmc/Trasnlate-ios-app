//
//  Enums.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import Foundation
import UIKit
import SwiftUI

struct AppColors {
    static let background = Color(red: 0.95, green: 0.96, blue: 0.97)
    static let purple = Color(red: 0.35, green: 0.28, blue: 0.85)
    static let secondary = Color(red: 0.29, green: 0.33, blue: 0.49)
}
struct AppUIColors {
    static let background = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
    static let purple = UIColor(red: 0.35, green: 0.28, blue: 0.85, alpha: 1)
    static let secondary = UIColor(red: 0.29, green: 0.33, blue: 0.49, alpha: 1)
}


var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

enum Screen: CaseIterable{
    case Main
    case History
    case Saved
}

enum SaveDataType: String {
    case save = "savedData"
    case history = "historyData"
}

enum LanguageType: CaseIterable {
    case source
    case target
}
