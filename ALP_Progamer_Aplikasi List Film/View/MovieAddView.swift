//
//  MovieAddView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI


struct MovieAddView: View {
    @ObservedObject var controller: MovieListController
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var title = ""
    @State private var genre = ""
    @State private var releaseYear = ""
    
    @State private var isShowingMovieList = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Genre", text: $genre)
                TextField("Release Year", text: $releaseYear)
                
                Button(action: addMovie) {
                    Text("Add Movie")
                }
                .disabled(title.isEmpty || genre.isEmpty || releaseYear.isEmpty)
            }
            .navigationBarTitle("Add Movie")
        }
    }
    
    private func addMovie() {
        controller.addMovie(title: title, genre: genre, releaseYear: releaseYear)
        presentationMode.wrappedValue.dismiss()
    }
}

struct MovieAddView_Previews: PreviewProvider {
    static var previews: some View {
        MovieAddView(controller: MovieListController())
    }
}
