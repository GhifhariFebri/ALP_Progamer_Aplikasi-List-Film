//
//  ContentView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI


//View Semua
struct ContentView: View {
    @ObservedObject var controller: MovieListController
    
    var body: some View {
        TabView {
            MovieListView(controller: controller)
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(controller: MovieListController())
    }
}
