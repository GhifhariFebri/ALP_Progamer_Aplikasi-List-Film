//
//  Movie.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation

struct Movie: Identifiable {
    let id: String
    let title: String
    let genre: String
    let releaseYear: String
    let imageUrl: String?
    
    init(id: String = UUID().uuidString, title: String, genre: String, releaseYear: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.genre = genre
        self.releaseYear = releaseYear
        self.imageUrl = imageUrl
    }
}
