//
//  String+Date.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation

extension String {
    var date: Date? {
        // here we can check a bunch of different date inputs, but this is just to demo that. the flickr api associated with this project is consistently using a single format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}

extension Date {
    // Example: Jan 1, 12:16 PM
    var fullDateShortTimeStr: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self)
    }
}
