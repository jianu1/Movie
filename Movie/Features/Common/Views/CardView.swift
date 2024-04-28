//
//  CardView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI

struct CardView: View {
    
    let movie: Movie
    var isFavorite: Bool
    var toggleFavorite: () -> Void // Funcție pentru a inversa starea de favorit

    var body: some View {
        VStack {
            Image(movie.posterPath)
                .resizable()
                .frame(width: 180, height: 270)
                .cornerRadius(5, corners: .allCorners)
            HStack {
                Text(movie.releaseDate.prefix(4))
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                HStack {
                    Image("ic_star")
                        .frame(width: 14, height: 14)
                    Text(String(movie.voteAverage))
                        .font(.system(size: 14, weight: .semibold))
                }
                Spacer()
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(self.isFavorite ? "ic_add_to_favorites_red" : "ic_add_to_favorites_black")
                        .frame(width: 14, height: 12.25)
                }

            }
            .padding(.horizontal, 14)
        }
        .frame(width: 180, height: 310)
        .background(.green)
        .cornerRadius(5, corners: .allCorners)
    }
}

#Preview {
        // Definim un `State` pentru a simula starea de favorit
        @State var isFavorite = true
        
        // Returnăm un CardView în care furnizăm starea de favorit și o implementare a toggleFavorite
        return CardView(
            movie: Movie(id: 123, voteCount: 1, video: false, voteAverage: 8.6, title: "MR.Robot", popularity: 7.34, posterPath: "", originalLanguage: "English", originalTitle: "English", genreIds: [18,22], backdropPath: "", adult: false, overview: "", releaseDate: "2016-08-28"),
            isFavorite: isFavorite,
            // Implementăm toggleFavorite pentru a schimba starea de favorit în previzualizare
            toggleFavorite: {
                isFavorite.toggle()
            }
        )
}