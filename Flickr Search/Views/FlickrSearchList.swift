//
//  ContentView.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import SwiftUI

struct FlickrSearchList: View {
    @StateObject private var debouncingSearchTextManager = DebouncingSearchTextManager()
    @StateObject private var imageListViewModel = FlickrImageListViewModel(imageService: FlickrImageService())
    
    var body: some View {
        NavigationStack {
            switch imageListViewModel.state {
            case .idle:
                Text("Enter a comma separated list of topics to search for related images")
                    .padding()
            case .failed(let err):
                Text("Search result fetch failed with \(err.localizedDescription)")
                    .padding()
            case .loading:
                ProgressView()
            case .loaded(let images):
                List(images) { image in
                    NavigationLink {
                        FlickrImageDetail(image: image)
                    } label: {
                        FlickrImageRow(image: image)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Flickr Image Search")
            }
        }
        
        .searchable(text: $debouncingSearchTextManager.searchText)
        .onChange(of: debouncingSearchTextManager.debouncedSearchText) {
            imageListViewModel.fetchImages(for: debouncingSearchTextManager.debouncedSearchText)
        }
    }
}

#Preview {
    FlickrSearchList()
}
