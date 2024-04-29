//
//  FavoriteMovies.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 29.04.2024.
//

import Foundation
import UIKit

class FavoriteMovies: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var images: [Int: UIImage] = [:]

    func addFavorite(movie: Movie, withImage image: UIImage?) {
        if !movies.contains(movie) {
            movies.append(movie)
            images[movie.id] = image
            objectWillChange.send()
        }
    }

    func removeFavorite(movie: Movie) {
        if let index = movies.firstIndex(of: movie) {
            movies.remove(at: index)
            images.removeValue(forKey: movie.id)
            objectWillChange.send()
        }
    }

    func updateImage(for movieId: Int, image: UIImage) {
        if let index = movies.firstIndex(where: { $0.id == movieId }) {
            images[movieId] = image
            objectWillChange.send()
        }
    }
}
