//
//  SearchView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        Text("SearchView")
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
