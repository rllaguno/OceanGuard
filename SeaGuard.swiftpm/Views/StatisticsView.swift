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
    @AppStorage("blue") private var blue = 0
    @AppStorage("green") private var green = 0
    @AppStorage("orange") private var orange = 0
    @AppStorage("red") private var red = 0
    
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
                
                Image("StatsTitle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 400)
                
                MultiSpacer(quantity: 3)

            }
            
            HStack {
                Spacer()
                
                VStack {
                    MultiSpacer(quantity: 1)
                    
                    TutorialSpeechBubble(text: "Thank you for helping us preserve and", text2: "clean our oceans! Your work so far:", length: 450)
                    
                    TitleAnimation(type: "Mono Neutral")
                }
                
                Spacer()
                
                VStack {
                    HighscoreBox(text: "Most trash picked in a run:", number: highScore, text2: "items")
                    HStack {
                        StatBox(text: "Total trash picked:", number: total, text2: "items")
                        ItemBox(type: "Botella Aplastada", quantity: blue)
                        ItemBox(type: "Botella Torcida", quantity: green)
                    }
                    HStack {
                        StatBox(text: "Total Sea Guard runs:", number: runs, text2: "runs")
                        ItemBox(type: "Bolsa CONAD", quantity: orange)
                        ItemBox(type: "Lata", quantity: red)
                    }
                }
                
                Spacer()
            }
            
        }
        .background(.teal.gradient)

    }
}

#Preview {
    StatisticsView()
}
