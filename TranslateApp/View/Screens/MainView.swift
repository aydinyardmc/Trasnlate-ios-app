//
//  MainView.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import SwiftUI

struct MainView: View {
    @State var text: String = ""
    @State var translatedText: String = ""
    @State var languages: [Language] = []
    @State var source: Language = Language(code: "detect", name: "Detect")
    @State var target: Language = Language(code: "en", name: "English")
    @State var showSourceModal: Bool = false
    @State var showTargetModal: Bool = false
    @FocusState private var focused: Bool
    @EnvironmentObject var languageVM: LanguageViewModal
    
    
    private func copyText(_ text: String) {
        UIPasteboard.general.setValue(text, forPasteboardType: "public.plain-text")
    }
    private func saveHistoryTranslateData() {
        var list = UserDefaults.standard.historyList
        print("saveTranslateData",list, self.languageVM.translateData)
        if ((list.first(where: { $0.translatedText == self.translatedText || $0.text == self.translatedText})) == nil){
            list.append(Translate(text: self.text, translatedText: self.translatedText, soruce: self.source, target: self.target))
        }
        UserDefaults.standard.historyList = list
        print("historyList changed",list)
        
    }
    private func saveTranslateData() {
        if(translatedText != "" ){
            var list = UserDefaults.standard.savedList
            print("saveTranslateData",list)
            
            if ((list.first(where: { $0.translatedText == self.translatedText || $0.text == self.translatedText})) == nil){
                list.append(self.languageVM.translateData)
            }
            UserDefaults.standard.savedList = list
            print("saveTranslateData changed",list)
        }
    }
    private func clearText() {
        self.text = ""
        self.translatedText = ""
        self.languageVM.translateData = Translate(text: "", translatedText: "")
    }
    
    private func translateText(text: String, source: Language, target: Language) {
        if(text != ""){
            self.languageVM.translateData.text = text
            self.languageVM.translateData.soruce = source
            self.languageVM.translateData.target = target
            self.languageVM.fetchTranslatedText(text: self.text, source: self.source.code , target: self.target.code)
        }
    }
    
    private func changeLanguages() {
        if(self.source.code != "detect"){
            (self.source, self.target) = (self.target, self.source)
            (self.text, self.translatedText) = (self.translatedText, self.text)
            self.translateText(text: self.text, source: self.source, target: self.target)
        }
    }
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                ZStack{
                    // translate label
                    LinearGradient(colors: [AppColors.purple,Color(red: 0.37, green: 0.32, blue: 0.84),AppColors.purple], startPoint: .bottom, endPoint: .top).cornerRadius(15)
                    HStack(spacing:30){
                        AppButton(action: {self.showSourceModal = true}){
                            HStack(spacing:5){
                                AppText(self.source.name, weight: .medium, color: .white)
                                AppIcon("downArrow2", width: 16, height: 16, color: .white)
                            }
                        }.fullScreenCover(isPresented: $showSourceModal){
                            LanguagesView(showModal: $showSourceModal, languages: languageVM.languages, selectedLangugage: $source, type: .source)
                        }
                        AppButton(action: {changeLanguages()}){
                            Image(systemName: "arrow.left.arrow.right").foregroundColor(.white)
                        }
                        
                        AppButton(action: {self.showTargetModal = true}){
                            HStack(spacing:5){
                                AppText(self.target.name, weight: .medium, color: .white)
                                AppIcon("downArrow2", width: 16, height: 16, color: .white)
                            }
                        }.fullScreenCover(isPresented: $showTargetModal){
                            LanguagesView(showModal: $showTargetModal, languages: languageVM.languages, selectedLangugage: $target, type: .target)
                        }
                    }
                }.frame(width: screenWidth-60, height: 80, alignment: .center)
                
                // text
                VStack(alignment: .trailing){
                    //                    TextEditor(text: $text)
                    //                        .submitLabel(.done)
                    //                        .frame(width: screenWidth-100, height: 150, alignment: .leading)
                    //                        .multilineTextAlignment(.leading)
                    //                        .background(Color.white)
                    //                        .focused($focused)
                    //                        .foregroundColor(AppColors.secondary)
                    //                        .toolbar(){
                    //                            ToolbarItemGroup(placement: .keyboard) {
                    //                                Button("Done") {
                    //                                    focused = false
                    //                                    print("source text: \(self.text)")
                    //                                    self.translateText(text: self.text, source: self.source , target: self.target)
                    //                                }.frame(width: .infinity, height: .none, alignment: .trailing)
                    //                            }
                    //                        }
                    MultilineTextField("", text: $text, onCommit: {self.translateText(text: self.text, source: self.source , target: self.target)})
                    
                    !text.isEmpty ? AnyView(HStack{
                        
                        AppButton(width: 30, height: 30, action: {copyText(self.text)}){
                            AppIcon("copy", width: 20, height: 20)
                        }
                        AppButton(width: 30, height: 30, action: {clearText()}){
                            AppIcon("delete", width: 15, height: 15)
                        }
                        
                    })
                    :
                    AnyView(EmptyView())
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .background(Color.white)
                .cornerRadius(15)
                
                // translatedText
                VStack(alignment: .trailing){
                    
                    !translatedText.isEmpty ? AnyView(HStack{
                        AppButton(width: 30, height: 30, action: {copyText(self.translatedText)}){
                            AppIcon("copy", width: 20, height: 20)
                        }
                        AppButton(width: 30, height: 30, action: {saveTranslateData()}){
                            AppIcon("star", width: 20, height: 20)
                        }
                        
                    })
                    :
                    AnyView(EmptyView())
                    
                    ScrollView(showsIndicators: false) {
                        Text(translatedText)
                            .lineLimit(nil)
                            .foregroundColor(AppColors.secondary)
                    }.frame(width: screenWidth-100, height: 150, alignment: .leading)
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .background(Color.white)
                .cornerRadius(15)
                .ignoresSafeArea(.keyboard)
            }
        }.onAppear{
            print("MainView:", self.languageVM.translateData)
            self.text =  self.languageVM.translateData.text!
            self.translatedText =  self.languageVM.translateData.translatedText!
            self.source =  self.languageVM.translateData.soruce!
            self.target =  self.languageVM.translateData.target!
        }
        .onChange(of: self.languageVM.languages, perform: { language in
            print("fetch language:", language)
        })
        .onChange(of: self.languageVM.translateData.translatedText, perform: { text in
            print("translated tex:", text!)
            self.translatedText = text!
            saveHistoryTranslateData()
        })
        .onChange(of: self.source, perform: { language in
            print("source language:", language)
            self.translateText(text: self.text, source: language, target: self.target)
        })
        .onChange(of: self.target, perform: { language in
            print("target language:", language)
            self.translateText(text: self.text, source: self.source, target: language)
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(AppColors.background)
        //        .ignoresSafeArea(.keyboard)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
