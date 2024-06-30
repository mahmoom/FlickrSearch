//
//  Tag.swift
//  Flickr Search
//
//  Created by Suhaib Mahmood on 6/29/24.
//

import Foundation
import SwiftUI

struct Tag: Identifiable {
    let id = UUID()
    let color: Color
    let title: String
}
