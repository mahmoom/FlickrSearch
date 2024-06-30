//
//  DebouncingSearchTextManager.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import Combine

class DebouncingSearchTextManager: ObservableObject {
    @Published var searchText: String = ""
    @Published var debouncedSearchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    init(searchTextDelay: TimeInterval = 0.3){
        self.$searchText
            .debounce(for: .seconds(searchTextDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
          .sink { [weak self] searchText in
            self?.debouncedSearchText = searchText
        }.store(in: &cancellables)
    }
}
