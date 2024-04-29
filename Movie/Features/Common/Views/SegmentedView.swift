//
//  SegmentedView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 29.04.2024.
//

import Foundation
import SwiftUI

enum MovieCategory: String, CaseIterable {
    case nowPlaying = "Now playing"
    case popular = "Popular"
    case topRated = "Top rated"
    case upcoming = "Upcoming"
    
    var displayName: String {
        self.rawValue
    }
}

struct SegmentedView: View {
    
    let segments: [MovieCategory]
    @Binding var selected: MovieCategory
    var actions: ((MovieCategory) -> Void)
    @Namespace var name
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                    actions(segment)
                } label: {
                    VStack {
                        Text(segment.displayName)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(selected == segment ? .white : Color(uiColor: .white))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected == segment {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(.black)
    }
}
