//
//  CustomDivider.swift
//  iLaw
//
//  Created by Evgeniy Safin on 28.01.2023.
//

import SwiftUI

extension View {
    func divider(linewidth: CGFloat = 1.0, _ alignment: Alignment) -> some View {
        self
            .overlay(alignment: alignment) {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [
                            .clear,
                            Color.white,
                            .clear
                        ]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(height: linewidth)
            }
    }
}
