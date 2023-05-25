//
//  MovieListView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var controller: MovieListController
    @State private var isPresentingAddMovieView = false
    
    var body: some View {
        NavigationView {
            List(controller.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    Text(movie.title)
                }
            }
            .navigationBarTitle("Movie List")
            .navigationBarItems(trailing:
                Button(action: { isPresentingAddMovieView = true }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $isPresentingAddMovieView) {
            MovieAddView(controller: controller)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(controller: MovieListController())
    }
}
