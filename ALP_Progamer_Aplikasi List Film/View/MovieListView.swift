//
//  MovieListView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import UIKit

// pembuatan struct movie list view
struct MovieListView: View {
    @ObservedObject var controller: MovieListController
    @State private var isPresentingAddMovieView = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                List(filteredMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        HStack {
                            if let imageUrlString = movie.imageUrl, let imageUrl = URL(string: imageUrlString) {
                                AsyncImageView(url: imageUrl)
                                    .frame(width: 150, height: 200)
                            } else {
                                Color.gray // Placeholder image bila imageUrl nil
                            }
                            
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.headline)
                                Text("Release Year: \(movie.releaseYear)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                RatingView(rating: movie.rating) // Display movie rating jadi bintang
                            }
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
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return controller.movies
        } else {
            return controller.movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct AsyncImageView: View {
    let url: URL
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Color.gray
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                image = UIImage(data: data)
            }
        }.resume()
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(controller: MovieListController())
    }
}
