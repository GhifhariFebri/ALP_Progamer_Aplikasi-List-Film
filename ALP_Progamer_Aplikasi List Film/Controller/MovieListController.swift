//
//  MovieListController.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation

class MovieListController: ObservableObject {
    @Published var movies: [Movie] = []
    
    func addMovie(title: String, genre: String, releaseYear: String) {
        let movie = Movie(title: title, genre: genre, releaseYear: releaseYear)
        movies.append(movie)
    }
}
