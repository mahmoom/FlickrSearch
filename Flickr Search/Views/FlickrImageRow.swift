//
//  FlickrImageRow.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import SwiftUI

struct FlickrImageRow: View {
    var image: FlickrImage
    var body: some View {
        // AsyncImage convenient, so we'll use it for now. Especially given the time constraints for this project. But in a real production use case, the lack of control over caching and stopping/continuing image load to maintain high performance is a limitation of this API
        AsyncImage(url: URL(string: image.media.urlString)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 128, height: 128)
        .clipShape(.rect(cornerRadius: 12))
    }
}
