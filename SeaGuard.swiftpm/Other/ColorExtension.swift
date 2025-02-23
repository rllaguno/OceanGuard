//
//  File.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import Foundation
import SwiftUI

extension Color {
    static let speechBubble = Self(hex: "FFFFFF")
}

extension Color {
    init(hex: String) {
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
