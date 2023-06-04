//
//  MovieListController.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

//  Movie list controller class
class MovieListController: ObservableObject {
    @Published var movies: [Movie] = []
    private var db = Firestore.firestore()
    private var collectionName = "Movie List" // Nama koleksi firebase
    
    init() {
        fetchMovies()
    }
    
    //Show Movie
    func fetchMovies() {
    
        db.collection(collectionName).getDocuments { snapshot, error in
            
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self.movies = snapshot.documents.compactMap { document in
                let data = document.data()
                let title = data["title"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let releaseYear = data["releaseYear"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""
                let synopsis = data["synopsis"] as? String ?? ""
                let rating = data["rating"] as? Int ?? 0
                let producer = data["producer"] as? String ?? ""
                
                
                return Movie(id: document.documentID, title: title, genre: genre, releaseYear: releaseYear, imageUrl: imageUrl, synopsis: synopsis, rating: rating, producer: producer)
            }
        }
    }
    
    func addMovie(title: String, genre: String, releaseYear: String, imageUrl: String, synopsis: String, rating: Int, producer: String) {
        let data: [String: Any] = [
            "title": title,
            "genre": genre,
            "releaseYear": releaseYear,
            "imageUrl": imageUrl,
            "synopsis": synopsis,
            "rating": rating,
            "producer": producer
        ]
        
        db.collection(collectionName).addDocument(data: data) { [weak self] error in
            if let error = error {
                print("Error adding movie: \(error.localizedDescription)")
            } else {
                // Fetch movie data
                self?.db.collection(self?.collectionName ?? "").whereField("title", isEqualTo: title)
                    .whereField("genre", isEqualTo: genre)
                    .whereField("releaseYear", isEqualTo: releaseYear)
                    .whereField("imageUrl", isEqualTo: imageUrl)
                    .whereField("synopsis", isEqualTo: synopsis)
                    .whereField("rating", isEqualTo: rating)
                    .whereField("producer", isEqualTo: producer)
                    .getDocuments { [weak self] snapshot, error in
                        if let error = error {
                            print("Error fetching movie: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let document = snapshot?.documents.first else {
                            print("Error: No matching movie document found")
                            return
                        }
                        
                        let movie = Movie(id: document.documentID, title: title, genre: genre, releaseYear: releaseYear, imageUrl: imageUrl, synopsis: synopsis, rating: rating, producer: producer)
                        
                        DispatchQueue.main.async {
                            self?.movies.append(movie)
                        }
                        
                        print("Movie added successfully")
                    }
            }
        }
    }
}

