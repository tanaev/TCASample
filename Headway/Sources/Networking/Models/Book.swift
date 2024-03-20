//
//  Book.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 24.12.2023.
//

import Foundation

struct Book: Decodable, Equatable, Sendable {
    let coverImageUrl: URL
    let keyPoints: [BookKeyPoint]
}
