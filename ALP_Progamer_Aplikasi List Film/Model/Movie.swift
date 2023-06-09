//
//  Movie.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

//  Movie model
import Foundation

struct Movie: Identifiable {
    let id: String
    let title: String
    let genre: String
    let releaseYear: String
    let imageUrl: String?
    let synopsis: String
    let rating: Int
    let producer: String
    
    init(id: String = UUID().uuidString, title: String, genre: String, releaseYear: String, imageUrl: String, synopsis: String, rating: Int, producer: String) {
        self.id = id
        self.title = title
        self.genre = genre
        self.releaseYear = releaseYear
        self.imageUrl = imageUrl
        self.synopsis = synopsis
        self.rating = rating
        self.producer = producer
    }
}
