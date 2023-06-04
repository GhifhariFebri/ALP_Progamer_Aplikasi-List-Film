//
//  ALP_Progamer_Aplikasi_List_FilmApp.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI
import Firebase


//Implement configure Firebase
@main
struct ALP_Progamer_Aplikasi_List_FilmApp: App {
    @State private var showSplash = true

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                //Setting splash screen
                if showSplash {
                    SplashScreenView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showSplash = false
                            }
                        }
                } else {
                    ContentView(controller: MovieListController())
                }
            }
        }
    }
}
