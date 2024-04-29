//
//  MovieController.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 29.04.2024.
//

import Foundation

class MovieController: ObservableObject {
    @Published private(set) var favoriteMovies = FavoriteMovies()
    
    func isFavorite(movieID: Movie) -> Bool {
        return favoriteMovies.movies.contains(movieID)
    }
    
    func toggleFavorite(movieID: Movie) {
        if let index = favoriteMovies.movies.firstIndex(of: movieID) {
            favoriteMovies.movies.remove(at: index)
        } else {
            favoriteMovies.movies.append(movieID)
        }
    }
}
