//
//  Array+Extension.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 27.12.2023.
//

import Foundation

extension Array where Element: Equatable {
    func nextItem(after currentItem: Element) -> Element? {
        guard let currentIndex = firstIndex(of: currentItem) else { return nil }
        let nextIndex = (currentIndex + 1) % count
        return self[nextIndex]
    }
}
