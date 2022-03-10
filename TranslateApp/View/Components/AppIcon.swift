//
//  AppIcon.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import SwiftUI

struct AppIcon: View {
    var width : CGFloat
    var height : CGFloat
    var color: Color
    var name: String
    
    init(_ name: String, width : CGFloat = 28, height : CGFloat = 28, color : Color = AppColors.secondary) {
        self.name = name
        self.width = width
        self.height = height
        self.color = color
    }
    var body: some View {
        Image(name)
            .resizable()
            .renderingMode(.template)
            .frame(width: width, height: height)
            .foregroundColor(color)
    }
}

//struct AppIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        AppIcon()
//    }
//}
