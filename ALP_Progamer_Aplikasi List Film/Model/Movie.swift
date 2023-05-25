//
//  Movie.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let genre: String
    let releaseYear: String
}
