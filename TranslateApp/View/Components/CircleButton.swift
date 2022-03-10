//
//  CircleButton.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import SwiftUI

struct CircleButton<Content: View>: View {
    var content: () -> Content
    var size : CGFloat
    var action: () -> Void
    var backgroundColor: Color
    
    init(size : CGFloat, backgroundColor: Color = .white, action: @escaping () -> Void, content: @escaping () -> Content) {
        self.size = size
        self.backgroundColor = backgroundColor
        self.action = action
        self.content = content
    }
    
    var body: some View {
        
        Button(action: self.action,
               label: {
                content()
        }).buttonStyle(CircleButtonButtonStyle(size: size, backgroundColor: backgroundColor))
        
    }
}

struct CircleButtonButtonStyle: ButtonStyle {
    @Environment(\.isFocused) var isFocused
    var size : CGFloat
    var backgroundColor: Color
    
    init(size : CGFloat, backgroundColor: Color) {
        self.size = size
        self.backgroundColor = backgroundColor
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size, height: size, alignment: .center)
            .background(backgroundColor)
            .cornerRadius(size/2)
//            .shadow(color: .white.opacity(isFocused ? 1 : 0), radius: 4, x: 0, y: 3)
            .scaleEffect(x: configuration.isPressed ? 0.9 : 1, y: configuration.isPressed ? 0.9 : 1, anchor: .center)
            .animation(.easeInOut, value: configuration.isPressed)
        
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(size: 20, action: {}, content: {Image("home")})
    }
}
