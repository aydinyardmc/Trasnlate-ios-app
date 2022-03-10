//
//  ContentView.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import SwiftUI
import UIKit



struct ContentView: View {
    var languageVM: LanguageViewModal = LanguageViewModal()
    @EnvironmentObject var screenVM: ScreenViewModal
    
    var body: some View {
        ZStack{
            switch screenVM.screen {
            case .Main:
                NavigationView{
                    MainView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle(Text("Translate"))
                }
            case .History:
                NavigationView{
                    HistoryView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle(Text("History"))
                }
            case .Saved:
                NavigationView{
                    SavedView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle(Text("Saved"))
                }
            }
            VStack{
                Spacer()
                TabBar()
            }
            
        }
        .environmentObject(languageVM)
        .frame(width: screenWidth, height: screenHeight,alignment: .bottom)
        .background(AppColors.background)
        .onAppear{
            let navBar =  UINavigationBarAppearance()
            navBar.titleTextAttributes = [.foregroundColor: AppUIColors.purple]
            navBar.largeTitleTextAttributes = [.foregroundColor: AppUIColors.purple]
            navBar.backgroundColor = AppUIColors.background
            navBar.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = navBar
            UINavigationBar.appearance().compactAppearance = navBar
            UINavigationBar.appearance().scrollEdgeAppearance = navBar
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


