//
//  AppButton.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import SwiftUI

struct AppButton<Content: View>: View {
    var content: () -> Content
    var width : CGFloat
    var height : CGFloat
    var action: () -> Void
    
    init(width : CGFloat = .infinity, height : CGFloat = .infinity, action: @escaping () -> Void, content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.action = action
        self.content = content
    }
    
    var body: some View {
        
        Button(action: self.action,
               label: {
            content()
        }).buttonStyle(AppButtonStyle(width: width, height: height))
    }
}

struct AppNavigateButton<Content: View>: View {
    var content: () -> Content
    var width : CGFloat
    var height : CGFloat
    var destination: AnyView
    
    init(width : CGFloat = .infinity, height : CGFloat = .infinity, destination : AnyView, content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.destination = destination
        self.content = content
    }
    
    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                content()
            })
            .buttonStyle(AppButtonStyle(width: width, height: height))
    }
}


struct AppButtonStyle: ButtonStyle {
    @Environment(\.isFocused) var isFocused
    var width: CGFloat
    var height: CGFloat
    
    init(width: CGFloat, height: CGFloat){
        self.width = width
        self.height = height
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height, alignment: .center)
        //            .shadow(color: .white.opacity(isFocused ? 1 : 0), radius: 4, x: 0, y: 3)
            .scaleEffect(x: configuration.isPressed ? 0.6 : 1, y: configuration.isPressed ? 0.6 : 1, anchor: .center)
            .animation(.easeInOut, value: configuration.isPressed)
        
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(width: 100, height: 100, action: {}, content: {Text("button")})
    }
}

