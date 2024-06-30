//
//  FlickrImageDetail.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import SwiftUI

struct FlickrImageDetail: View {
    
    private var image: FlickrImage
    private var tagViewModel: TagViewModel
    
    init(image: FlickrImage) {
        self.image = image
        tagViewModel = .init(tagsString: image.tags)
    }
    
    var body: some View {
        // scroll view will allow dynamic text sizing support
        ScrollView(.vertical) {
            VStack(alignment: .center) {
                Text(image.title)
                    .font(.title)
                AsyncImage(url: URL(string: image.media.urlString))
                Text("Taken by \(image.author) on \(image.dateTaken.date?.fullDateShortTimeStr ?? image.dateTaken)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Tags: ")
                    .font(.title2)
                TagsView(tagsViewModel: tagViewModel)
                if let url = URL(string: image.media.urlString) {
                    ShareLink(item: url)
                }
            }
            .padding()
        }
    }
}
