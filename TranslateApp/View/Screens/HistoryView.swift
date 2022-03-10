//
//  HistoryView.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import SwiftUI

struct HistoryView: View {
    @State var list: [Translate] = []
    @EnvironmentObject var languageVM: LanguageViewModal
    @EnvironmentObject var screenVM: ScreenViewModal
    
    func translateText(language: Translate) {
        languageVM.translateData = language
        screenVM.screen = .Main
        
    }
    var body: some View {
        VStack{
            
            ScrollView(showsIndicators: false){
                LazyVStack{
                    ForEach(list.indices, id:\.self){ index in
                        
                        TextCard(text: list[index].text ?? "", translatedText: list[index].translatedText ?? "", action: {translateText(language: list[index])})
                        
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 100, trailing: 0))
            }
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            .background(AppColors.background)
            .onAppear{
                self.list = Array(UserDefaults.standard.historyList.reversed())
            }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
