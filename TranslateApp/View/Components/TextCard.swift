//
//  TextCard.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 10.03.2022.
//

import SwiftUI

struct TextCard: View {
    @State var text: String = ""
    @State var translatedText: String = ""
    var limit: Int = 200
    var action: () -> Void
    
    init(text: String, translatedText: String, action: @escaping () -> Void) {
        self.text = text
        self.translatedText = translatedText
        self.action = action
    }
    
    var body: some View {
                AppButton(action: self.action){
        VStack{
            VStack{
                AppText(text, weight: .medium, color: AppColors.secondary).padding(.bottom, 5)
            }.frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
            
            VStack{
                AppText(translatedText, weight: .medium, color: AppColors.secondary).opacity(0.7)
            }.frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
        }
        .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(.white)
        .cornerRadius(15)
        .padding(.top,6)
        
                }
        .onAppear{
            if text.count > limit {
                text = String(text.prefix(limit))
                text.append(contentsOf: "...")
            }
            if translatedText.count > limit {
                translatedText = String(translatedText.prefix(limit))
                translatedText.append(contentsOf: "...")
            }
        }
    }
}

struct TextCard_Previews: PreviewProvider {
    static var previews: some View {
        TextCard(text: "test", translatedText: "test test test test", action: {})
    }
}
