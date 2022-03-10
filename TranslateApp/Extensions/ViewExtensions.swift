//
//  ViewExtensions.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import SwiftUI
import UIKit

extension View {
    func viewBar<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        return self.overlay(
            ZStack (alignment: .bottom){
                AppColors.background
                content()
            }.frame(height: 80)
            .frame(maxHeight: .infinity, alignment: .top)
               
        )
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


