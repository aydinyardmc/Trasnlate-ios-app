//
//  LanguagesView.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 10.03.2022.
//

import SwiftUI
import Alamofire

struct LanguagesView: View {
    @State var text: String = ""
    @State var searchResults: [Language] = []
    var languages: [Language]
    @Binding var showModal: Bool
    @Binding var selectedLangugage: Language
    var type: LanguageType
    init(showModal: Binding<Bool>, languages: [Language], selectedLangugage: Binding<Language>, type: LanguageType) {
        self._showModal = showModal
        self.languages = languages
        self._selectedLangugage = selectedLangugage
        self.type = type
    }
    
    func search(_ text:String) {
        if(text != ""){
            searchResults = []
            for item in languages {
                if item.name.lowercased().contains(text.lowercased()) {
                    searchResults.append(item)
                }
            }
        } else {
            searchResults = languages
        }
    }
    
    func changeLanguage(language: Language) {
        self.selectedLangugage = language
        self.showModal = false
    }
    var body: some View {
        VStack{
            HStack(){
                AppButton(width: 30, height: 30, action: {self.showModal = false}){
                    AppIcon("back", width: 30,height: 30)
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }.padding(.top,10)
            
            TextField("Search language here...", text: $text).frame(height: 60).padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 40))
                .foregroundColor(AppColors.secondary)
                .overlay(
                    ZStack(alignment: .trailing){
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppColors.purple, lineWidth: 2)
                        AppIcon("search", width: 20, height: 20, color: AppColors.purple).padding(.trailing,15)
                    }
                )
                .onChange(of: self.text, perform: {newValue in
                    search(newValue)
                })
            
            ScrollView(showsIndicators: false) {
                LazyVStack{
                    ForEach(searchResults.indices, id:\.self){ index in
                        
                        AppButton(action: {changeLanguage(language: searchResults[index])}){
                            VStack{
                                AppText(searchResults[index].name,weight: .medium,color: selectedLangugage.name == searchResults[index].name ? .white : AppColors.secondary)
                            }
                            .frame(height: 60)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(selectedLangugage.name == searchResults[index].name ? AppColors.purple : .white)
                            .cornerRadius(15)
                            .padding(.top,6)
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            .background(AppColors.background)
            .onAppear{
                print("languagesview : ",languages)
                if (type == .source){
                self.searchResults.append(Language(id: "1", code: "detect", name: "Detect"))
                self.searchResults.append(contentsOf: languages)
                } else {
                    self.searchResults = languages
                }
                
            }
    }
}
//
//struct LanguagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguagesView()
//    }
//}
