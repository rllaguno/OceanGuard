//
//  MultiSpacer.swift
//  CoinFlipper
//
//  Created by Rodrigo Llaguno on 06/12/24.
//

import SwiftUI

struct MultiSpacer: View {
    var quantity: Int
    
    var body: some View {
        ForEach(0..<quantity, id: \.self) { _ in
            Spacer()
        }
    }
}

#Preview {
    MultiSpacer(quantity: 5)
}
