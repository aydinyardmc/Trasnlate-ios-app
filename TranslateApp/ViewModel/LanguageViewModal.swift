//
//  LanguageViewModal.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import Foundation


class LanguageViewModal: ObservableObject {
    
    private var languageService: LanguageService!
    @Published var languages = [Language]()
    @Published var translateData: Translate = Translate(text: "", translatedText: "", soruce: Language(code: "detect", name: "Detect"), target: Language(code: "en", name: "English"))
    
    
    init(){
        self.languageService = LanguageService()
        fetchLanguages()
    }
    
    func fetchLanguages(){
        self.languageService.getLanguages(){ languages in
            if let languages = languages {
                self.languages = languages
            }
        }
    }
    
    func fetchTranslatedText(text: String, source: String, target:String){
        self.translateData.text = text
        if(source != "detect"){
            self.languageService.translateText(text: text, source: source, target: target){ text in
                if let text = text {
                    self.translateData.translatedText = text
                }
            }
        } else {
            self.languageService.detectText(text: text){ language in
                if let language = language {
                    let equalLanguage = self.languages.first {
                        $0.code == language
                    }
                    self.translateData.soruce = equalLanguage
                    self.languageService.translateText(text: text, source: equalLanguage!.code, target: target){ text in
                        if let text = text {
                            self.translateData.translatedText = text
                        }
                    }
                }
            }
        }
    }    
}
