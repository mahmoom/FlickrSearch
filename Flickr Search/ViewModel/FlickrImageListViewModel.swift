//
//  FlickrImageListViewModel.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import Combine

class FlickrImageListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    
    private var cancellables = Set<AnyCancellable>()
    private let imageService: FlickrImageServiceProtocol
    private var currentSearchStr = ""
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([FlickrImage])
    }
    
    init(imageService: FlickrImageServiceProtocol) {
        self.imageService = imageService
    }
    
    // could add cancellation of in flight request and only handle most recent request
    func fetchImages(for searchString: String) {
        currentSearchStr = searchString
        guard !searchString.isEmpty else {
            state = .idle
            return
        }
        state = .loading
        imageService.getImages(for: searchString)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completionStatus in
                switch completionStatus {
                case .finished: break
                case .failure(let failure):
                    self?.state = .failed(failure)
                }
        }, receiveValue: {[weak self] data in
            // ensure search results are for the most recently entered search string
            guard data.searchString == self?.currentSearchStr else {
                return
            }
            self?.state = .loaded(data.images)
        }).store(in: &cancellables)
    }
}
