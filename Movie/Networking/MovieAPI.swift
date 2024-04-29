//
//  MovieAPI.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 29.04.2024.
//

import Foundation

enum RecommendationType: String {
    case nowPlaying = "now_playing"
    case popular
    case topRated = "top_rated"
    case upcoming
}

class MovieAPI {
    private let apiKey = "abfabb9de9dc58bb436d38f97ce882bc"
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let urlSession = URLSession.shared

    func getRecommendations(type: RecommendationType) async throws -> [Movie] {
        let url = baseURL.appendingPathComponent("movie/\(type.rawValue)")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        let request = URLRequest(url: components.url!)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(MoviesResponse.self, from: data)
            return response.results
        } catch {
            throw error
        }
    }

    func searchMovies(query: String) async throws -> [Movie] {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(query)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await urlSession.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let movies = try JSONDecoder().decode([Movie].self, from: data)
        return movies
    }

    func fetchMovieDetails(movieId: Int) async throws -> Movie {
        let urlString = "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await urlSession.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let movie = try JSONDecoder().decode(Movie.self, from: data)
        return movie
    }
}
