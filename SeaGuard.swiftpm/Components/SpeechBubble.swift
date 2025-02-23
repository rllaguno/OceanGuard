//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 21/02/25.
//

import SwiftUI

struct SpeechBubble: View {
    let text: String
    let text2: String
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundStyle(Color.black)
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(45))
                .offset(x: 160, y: 40)
            
            Rectangle()
                .foregroundStyle(Color.speechBubble)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(45))
                .offset(x: 160, y: 40)
            
            Rectangle()
                .foregroundStyle(Color.black)
                .frame(width: 560, height: 110)
                .cornerRadius(20)
            
            Rectangle()
                .foregroundStyle(Color.speechBubble)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(45))
                .offset(x: 160, y: 40)
            
            Rectangle()
                .foregroundStyle(Color.speechBubble)
                .frame(width: 550, height: 100)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(text)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.black)
                Text(text2)
                    .font(.system(size: 24, weight: .semibold))
                    .offset(x: 60)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    SpeechBubble(text: "Ahoy Matey! Welcome to Sea Guard!", text2: "Click on me if you want to learn the ropes!")
}
