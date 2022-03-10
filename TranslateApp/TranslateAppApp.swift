//
//  TranslateAppApp.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 8.03.2022.
//

import SwiftUI

@main
struct TranslateAppApp: App {
    var screenVM: ScreenViewModal = ScreenViewModal()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(screenVM)
        }
    }
}
