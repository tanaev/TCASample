//
//  Int+Extension.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 23.12.2023.
//

import Foundation

extension Double {
    var durationString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
      }
}
