//
//  ALP_Progamer_Aplikasi_List_FilmApp.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI
import Firebase

@main
struct ALP_Progamer_Aplikasi_List_FilmApp: App {
    
    init() {
       FirebaseApp.configure()
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView(controller: MovieListController())
        }
    }
}
