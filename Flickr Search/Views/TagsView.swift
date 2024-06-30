//
//  TagView.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import SwiftUI

struct TagsView: View {
    var tagsViewModel: TagViewModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [ GridItem(.flexible()) ]) {
                ForEach(tagsViewModel.tags) { tag in
                    TagView(tag: tag)
                }
            }
        }
    }
}
private struct TagView: View {
    var tag: Tag
    var body: some View {
        Text(tag.title)
            .padding()
            .background(tag.color)
            .cornerRadius(8)
    }
}

#Preview {
    TagView(tag: .init(color: .red, title: "Sample"))
}
