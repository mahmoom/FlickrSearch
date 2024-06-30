//
//  FlickrImage.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation

struct FlickrImageResponse: Codable {
    let images: [FlickrImage]
    private enum CodingKeys: String, CodingKey {
        case images = "items"
    }
}

struct FlickrImage: Codable, Identifiable {
    let id = UUID()
    let title: String
    let media: FlickMediaObject
    let tags: String
    let dateTaken: String
    let author: String
    
    private enum CodingKeys: String, CodingKey {
        case title, media, tags, author
        case dateTaken = "date_taken"
    }
}

struct FlickMediaObject: Codable {
    let urlString: String
    private enum CodingKeys: String, CodingKey {
        case urlString = "m"
    }
}

struct FlickrImagesSearch {
    let searchString: String
    let images: [FlickrImage]
}
