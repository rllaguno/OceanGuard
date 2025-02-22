//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 21/02/25.
//

import SwiftUI

struct MenuButton: View {
    let name: String
    
    var body: some View {
        ZStack {
            Text(name)
                .font(.system(size: 45, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue]), startPoint: .top, endPoint: .bottom))
                )
        }
    }
}

#Preview {
    MenuButton(name: "Play")
}
