//
//  MovieDetailView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

// pembuatan struct movie detail view
struct MovieDetailView: View {
    let movie: Movie
    @State private var isLoading = true
    @State private var image: UIImage?
    
    var body: some View {
        VStack(alignment: .center){
            if isLoading {
                ProgressView()
            } else if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 350)
            } else {
                Text("Image not available")
            }
            
            Text("")
            
            if let rating = movie.rating {
                RatingView(rating: rating)
            } else {
                Text("Rating: N/A")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(movie.title)
                .font(.headline)
            
            Text("Producer: \(movie.producer)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Genre: \(movie.genre)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Release Year: \(movie.releaseYear)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("\n")
            
            VStack(alignment: .leading){
                Text("Synopsis")
                    .font(.headline)
                Text(movie.synopsis)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .navigationBarTitle(movie.title)
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let imageUrl = movie.imageUrl, let url = URL(string: imageUrl) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                isLoading = false
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                isLoading = false
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
                isLoading = false
            }
        }.resume()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(title: "Sample Movie", genre: "Action", releaseYear: "2021", imageUrl: "AppIcon", synopsis: "none", rating: 1, producer: "idk"))
    }
}
