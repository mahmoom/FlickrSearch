//
//  FlickrClient.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import Combine

enum FlickrClientError: Error {
    case networkFailure
    case parsingFailure
    case invalidURL
}


final class FlickrClient {
    
    /// Properties
    let session: URLSession
    
    // MARK: - Initializer
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getImages(for searchString: String) -> AnyPublisher<FlickrImagesSearch, Error> {
        guard let url = getURL(for: searchString) else {
            return Fail(error: FlickrClientError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw FlickrClientError.networkFailure
                }
                return data
            }
            .decode(type: FlickrImageResponse.self, decoder: JSONDecoder())
            .map { FlickrImagesSearch(searchString: searchString, images: $0.images) }
            .eraseToAnyPublisher()
    }
    
    // could make this more generic with an endpoint construction protocol, allowing us to protocolize the client class. That is out of scope for a single API request like in this project
    private func getURL(for searchString: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/feeds/photos_public.gne"
        components.queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "tags", value: searchString)
        ]
        
        return components.url
    }
}
