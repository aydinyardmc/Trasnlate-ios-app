//
//  TabBar.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var screenVM: ScreenViewModal
    
    func changeScreen(screen: Screen) {
        self.screenVM.screen = screen
    }
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 60){
                AppButton(action: {changeScreen(screen: .Saved)}){
                    AppIcon("star", color: AppColors.purple)
                }
                ZStack(alignment: .center){
                    Circle()
                        .frame(width: 80, height: 80).foregroundColor(.white)
                    CircleButton(size: 60, backgroundColor: AppColors.purple, action: {changeScreen(screen: .Main)}){
                        AppIcon("home", color: .white)
                    }
                }.padding(.bottom,50)
                AppButton(action: {changeScreen(screen: .History)}){
                    AppIcon("time-past", color: AppColors.purple)
                }
            }
            .padding(.bottom,15)
        }
        .frame(width: screenWidth, height: 80, alignment: .center)
        .background(Color.white)
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
