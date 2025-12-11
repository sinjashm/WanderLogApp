//
//  LucentBorder.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import SwiftUI

struct LucentBorderModifier: ViewModifier {
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.6),
                                Color.white.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.7
                    )
                    .blur(radius: 0.5)
            }
    }
}

extension View {
    func lucentBorder(radius: CGFloat = 16) -> some View {
        modifier(LucentBorderModifier(radius: radius))
    }
}
