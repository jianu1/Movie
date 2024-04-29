//
//  FavoriteViewModel.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI
import Combine
import Foundation
import SwiftfulRouting

protocol FavoriteViewModelProtocol {
    
}

final class FavoriteViewModel: ObservableObject {
    
    @Published var favoriteMovies: FavoriteMovies
    
    var images: [Int: UIImage] {
        favoriteMovies.images
    }

    private var cancellables = Set<AnyCancellable>()

    init(favoriteMovies: FavoriteMovies) {
        self.favoriteMovies = favoriteMovies

        favoriteMovies.$movies
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func removeFavorite(movieID: Movie) {
        favoriteMovies.removeFavorite(movie: movieID)
    }
}
