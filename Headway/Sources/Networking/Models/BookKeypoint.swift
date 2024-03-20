//
//  BookKeypoint.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 24.12.2023.
//

import Foundation

struct BookKeyPoint: Decodable, Equatable, Sendable {
    let description: String
    let audioUrl: URL
}
