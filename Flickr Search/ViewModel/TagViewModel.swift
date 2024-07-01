//
//  TagViewModel.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import SwiftUI

struct TagViewModel {
    var tags: [Tag] = []
    init(tagsString: String) {
        let tagsItems = tagsString.components(separatedBy: " ")
        tags = tagsItems.map { Tag(color: getRandomColor(), title: $0) }
    }
    
    private func getRandomColor() -> Color {
        return [Color.red, .yellow, .green, .blue, .orange].randomElement() ?? .cyan
    }
}
