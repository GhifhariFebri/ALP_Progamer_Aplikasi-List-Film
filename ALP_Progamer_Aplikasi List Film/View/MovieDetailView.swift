//
//  MovieDetailView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            Text("Title: \(movie.title)")
            Text("Genre: \(movie.genre)")
            Text("Release Year: \(movie.releaseYear)")
        }
        .navigationBarTitle(movie.title)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(title: "Sample Movie", genre: "Action", releaseYear: "2021"))
    }
}
