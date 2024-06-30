//
//  FlickrImageService.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import Combine

protocol FlickrImageServiceProtocol {
    func getImages(for searchString: String) -> AnyPublisher<FlickrImagesSearch, Error>
}

class FlickrImageService: FlickrImageServiceProtocol {
    let apiClient = FlickrClient()
    
    func getImages(for searchString: String) -> AnyPublisher<FlickrImagesSearch, Error> {
        return apiClient.getImages(for: searchString)
    }
}
