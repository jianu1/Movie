//
//  HomeViewModel.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI
import Combine
import Foundation
import SwiftfulRouting

protocol HomeViewModelProtocol {
    
}

class HomeViewModel: ObservableObject {
    
    @ObservedObject var favoriteMovies: FavoriteMovies

    @Published var movies: [Movie]
    @Published var images: [Int: UIImage] = [:]
    @Published var segments: [MovieCategory] = [.nowPlaying, .popular, .topRated, .upcoming]
    var movieController: MovieController
    private var movieAPI = MovieAPI()
    private var cancellables = Set<AnyCancellable>()
    
    init(movieController: MovieController) {
        self.movieController = movieController
        self.favoriteMovies = movieController.favoriteMovies
        
        movies = movieController.favoriteMovies.movies
        
        favoriteMovies.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func loadData(type: RecommendationType) async {
        do {
            let fetchedMovies = try await movieAPI.getRecommendations(type: .popular)
            await MainActor.run {
                self.movies = fetchedMovies
                self.loadImages(for: fetchedMovies)
            }
        } catch {
            print("Failed to load movies: \(error)")
        }
    }
    
    private func loadImages(for movies: [Movie]) {
        for movie in movies {
            guard let url = movie.fullPosterURL else { continue }
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        await MainActor.run {
                            self.images[movie.id] = image
                        }
                    }
                } catch {
                    print("Error loading image for \(movie.title): \(error)")
                }
            }
        }
    }
    
    func handleSelection(category: MovieCategory) async {
        switch category {
        case .nowPlaying:
            do {
                let fetchedMovies = try await movieAPI.getRecommendations(type: .nowPlaying)
                await MainActor.run {
                    self.movies = fetchedMovies
                    self.loadImages(for: fetchedMovies)
                }
            } catch {
                print("Failed to load movies: \(error)")
            }

        case .popular:
            do {
                let fetchedMovies = try await movieAPI.getRecommendations(type: .popular)
                await MainActor.run {
                    self.movies = fetchedMovies
                    self.loadImages(for: fetchedMovies)
                }
            } catch {
                print("Failed to load movies: \(error)")
            }
        case .topRated:
            do {
                let fetchedMovies = try await movieAPI.getRecommendations(type: .topRated)
                await MainActor.run {
                    self.movies = fetchedMovies
                    self.loadImages(for: fetchedMovies)
                }
            } catch {
                print("Failed to load movies: \(error)")
            }
        case .upcoming:
            do {
                let fetchedMovies = try await movieAPI.getRecommendations(type: .upcoming)
                await MainActor.run {
                    self.movies = fetchedMovies
                    self.loadImages(for: fetchedMovies)
                }
            } catch {
                print("Failed to load movies: \(error)")
            }
        }
    }


    func isFavorite(movieID: Movie) -> Bool {
        return movieController.isFavorite(movieID: movieID)
    }
    
    func toggleFavorite(movie: Movie) {
        if movieController.isFavorite(movieID: movie) {
            movieController.favoriteMovies.removeFavorite(movie: movie)
        } else {
            let image = images[movie.id]
            movieController.favoriteMovies.addFavorite(movie: movie, withImage: image)
        }
    }
    
    func sortMovies(by option: SortOption) {
        switch option {
        case .ratingAscending:
            movies.sort { $0.voteAverage < $1.voteAverage }
        case .ratingDescending:
            movies.sort { $0.voteAverage > $1.voteAverage }
        case .releaseDateAscending:
            movies.sort {
                guard let date0 = dateFromString($0.releaseDate), let date1 = dateFromString($1.releaseDate) else { return false }
                return date0 < date1
            }
        case .releaseDateDescending:
            movies.sort {
                guard let date0 = dateFromString($0.releaseDate), let date1 = dateFromString($1.releaseDate) else { return false }
                return date0 > date1
            }
        }
    }
}

enum SortOption {
    case ratingAscending, ratingDescending, releaseDateAscending, releaseDateDescending
}

extension HomeViewModel {
    private func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
}
