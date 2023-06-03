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

//  Movie list controller
class MovieListController: ObservableObject {
    @Published var movies: [Movie] = []
    private var db = Firestore.firestore()
    private var collectionName = "Movie List" // Update the collection name
    
    init() {
        fetchMovies()
    }
    
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
                
                return Movie(title: title, genre: genre, releaseYear: releaseYear, imageUrl: imageUrl)
            }
        }
    }
    
    func addMovie(title: String, genre: String, releaseYear: String, imageUrl: String) {
        let data: [String: Any] = [
            "title": title,
            "genre": genre,
            "releaseYear": releaseYear,
            "imageUrl": imageUrl
        ]
        
        db.collection(collectionName).addDocument(data: data) { [weak self] error in
            if let error = error {
                print("Error adding movie: \(error.localizedDescription)")
            } else {
                // Fetch the newly added movie document
                self?.db.collection(self?.collectionName ?? "").whereField("title", isEqualTo: title)
                    .whereField("genre", isEqualTo: genre)
                    .whereField("releaseYear", isEqualTo: releaseYear)
                    .whereField("imageUrl", isEqualTo: imageUrl)
                    .getDocuments { [weak self] snapshot, error in
                        if let error = error {
                            print("Error fetching movie: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let document = snapshot?.documents.first else {
                            print("Error: No matching movie document found")
                            return
                        }
                        
                        let movie = Movie(id: document.documentID, title: title, genre: genre, releaseYear: releaseYear, imageUrl: imageUrl)
                        
                        DispatchQueue.main.async {
                            self?.movies.append(movie)
                        }
                        
                        print("Movie added successfully")
                    }
            }
        }
    }
}

