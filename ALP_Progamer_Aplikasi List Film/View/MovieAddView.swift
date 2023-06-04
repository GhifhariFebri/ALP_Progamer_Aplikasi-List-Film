//
//  MovieAddView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 22/05/23.
//

//  Import
import SwiftUI
import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

// pembuatan Struck movie add view
struct MovieAddView: View {
    @ObservedObject var controller: MovieListController
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var title = ""
    @State private var genre = ""
    @State private var releaseYear = ""
    @State private var synopsis = ""
    @State private var producer = ""
    @State private var rating = 0 // New rating state
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Genre", text: $genre)
            TextField("Release Year", text: $releaseYear)
            TextField("Producer", text: $producer)
            TextField("Synopsis", text: $synopsis)
            
            Stepper(value: $rating, in: 0...5, step: 1) {
                Text("Rating: \(rating)")
            }
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
            }
            
            Button(action: {
                isShowingImagePicker = true
            }) {
                Text("Choose Image")
            }
            
            Button(action: addMovie) {
                Text("Add Movie")
            }
        }
        .navigationBarTitle("Add Movie")
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
    }
    
    private func addMovie() {
        print("Adding movie...") // Debuggin bila movie ke add
        
        guard let selectedImage = selectedImage else {
            print("No selected image")
            return
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            print("Error converting image to data")
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("\(UUID().uuidString).jpg")
        
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    return
                }
                
                if let downloadURL = url {
                    let imageUrl = downloadURL.absoluteString
                    print("Movie details: title=\(title), genre=\(genre), releaseYear=\(releaseYear), imageUrl=\(imageUrl), rating=\(rating)") // Print movie details
                    
                    controller.addMovie(title: title, genre: genre, releaseYear: releaseYear, imageUrl: imageUrl, synopsis: synopsis, rating: rating, producer: producer)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}


struct MovieAddView_Previews: PreviewProvider {
    static var previews: some View {
        MovieAddView(controller: MovieListController())
    }
}
