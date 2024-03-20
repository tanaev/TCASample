//
//  TouchDownButtonStyle.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 23.12.2023.
//

import SwiftUI

struct PlayerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(Circle().foregroundStyle(configuration.isPressed ? Color(.secondary) : Color.clear))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.linear(duration: 0.15), value: configuration.isPressed)
    }
}
