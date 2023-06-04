//
//  RatingView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 29/05/23.
//

import SwiftUI

//View rating sebagai bintang
struct RatingView: View {
    let rating: Int
    let maxRating = 5

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(index < rating ? .yellow : .gray)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 1)
    }
}
