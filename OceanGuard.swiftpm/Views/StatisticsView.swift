//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct StatisticsView: View {
    @AppStorage("highScore") private var highScore = 0
    @AppStorage("total") private var total = 0
    @AppStorage("runs") private var runs = 0
    
    @EnvironmentObject var appViewModel: AppViewModel

    
    var body: some View {
        VStack {
            HStack {
                MultiSpacer(quantity: 1)
                
                Button {
                    appViewModel.currentScreen = .title
                } label: {
                    BackButton()
                }
                .buttonStyle(.plain)
                
                MultiSpacer(quantity: 2)
                
                Text("Statistics")
                    .font(.system(size: 80, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding()
                
                MultiSpacer(quantity: 3)

            }
            
            HStack {
                Spacer()
                
                VStack {
                    MultiSpacer(quantity: 1)
                    
                    SpeechBubble(text: "Thank you for helping us preserve and", text2: "clean our oceans! Your work so far:")
                    
                    TitleAnimation()
                }
                
                Spacer()
                
                VStack {
                    StatBox(text: "Most trash picked in a session:", number: highScore, text2: "items")
                    StatBox(text: "Total trash picked:", number: total, text2: "items")
                    StatBox(text: "Total Ocean Guard runs:", number: runs, text2: "runs")
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    StatisticsView()
}
