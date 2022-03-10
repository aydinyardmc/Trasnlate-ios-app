//
//  AppText.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import SwiftUI

struct AppText: View {
    var text: String
    var size: CGFloat
    var weight: Font.Weight
    var color: Color
    
    init(_ text: String, size: CGFloat = 17, weight: Font.Weight = .regular, color: Color = AppColors.secondary) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
    }
    var body: some View {
        Text(text)
            .font(.system(size: size).weight(weight))
            .foregroundColor(color)
    }
}

struct AppText_Previews: PreviewProvider {
    static var previews: some View {
        AppText("text")
    }
}
