//
//  ColorTheme.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let palette = Palette()
}

struct Palette {
    let mercury: Color = Color("mercury")
    let lead: Color = Color("lead")
    let indigo: Color = Color.indigo
}
