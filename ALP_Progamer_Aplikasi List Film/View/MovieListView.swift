//
//  MovieListView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct MovieListView: View {
    @ObservedObject var controller: MovieListController
    @State private var isPresentingAddMovieView = false

    var body: some View {
        NavigationView {
            List(controller.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack {
                        if let imageUrl = movie.imageUrl, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 120)
                            } placeholder: {
                                // Placeholder image or activity indicator
                                Color.gray
                            }
                        } else {
                            Color.gray // Placeholder image when imageUrl is nil
                        }
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text("Release Year: \(movie.releaseYear)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
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
        .onAppear {
            controller.fetchMovies()
        }
    }
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(controller: MovieListController())
    }
}
