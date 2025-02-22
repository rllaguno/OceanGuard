//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct StatBox: View {
    var text: String
    var number: Int
    var text2: String

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black)
                .frame(width: 300, height: 120)
                .cornerRadius(20)

            Rectangle()
                .foregroundStyle(Color.white)
                .frame(width: 290, height: 110)
                .cornerRadius(20)
            
            Text(text)
                .offset(y: -20)
                .font(.system(size: 18))

            
            Text("\(String(number)) \(text2)")
                .offset(y: 20)
                .font(.system(size: 32, weight: .bold))

        }
    }
}

#Preview {
    StatBox(text: "Most trash picked in a session:", number: 192, text2: "items")
}
