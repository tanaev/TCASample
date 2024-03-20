//
//  APIClient.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 24.12.2023.
//

import Foundation
import ComposableArchitecture

// MARK: - API client interface

@DependencyClient
struct APIClient {
    var book: @Sendable () async throws -> Book
}

extension APIClient: TestDependencyKey {
    static let previewValue = Self(
        book: { .mock }
    )
    
    static let testValue = Self(
        book: { .mock }
    )
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

extension APIClient: DependencyKey {
    static let liveValue = APIClient(
        book: {
            let duration = UInt64(Int.random(in: 1...3) * 1_000_000_000)
            try await Task.sleep(nanoseconds: duration)
            let mockedData = Book.mockedJson.randomElement()?.data(using: .utf8) ?? Data()
            return try JSONDecoder().decode(Book.self, from: mockedData)
        }
    )
}
