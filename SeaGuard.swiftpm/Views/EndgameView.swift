//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct EndgameView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    @AppStorage("highScore") private var highScore = 0
    @AppStorage("total") private var total = 0
    @AppStorage("runs") private var runs = 0
    @AppStorage("blue") private var blue = 0
    @AppStorage("green") private var green = 0
    @AppStorage("orange") private var orange = 0
    @AppStorage("red") private var red = 0
    
    var isHighscore: Bool {
        if appViewModel.currentScore > highScore {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                MultiSpacer(quantity: 1)
                
                Button {
                    updateStats()
                    appViewModel.resetGame()
                    appViewModel.currentScreen = .title
                } label: {
                    BackButton()
                }
                .buttonStyle(.plain)
                
                MultiSpacer(quantity: 2)
                
                Image("RecapTitle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 400)
                
                MultiSpacer(quantity: 3)

            }
            
            HStack {
                Spacer()
                
                VStack {
                    MultiSpacer(quantity: 1)
                    
                    EndSpeechBubble(text: "Ye did a fine job cleanin’ the seas! The ocean be grateful", text2: "for yer hard work—keep sailin’ and savin’ the blue!", length: 650, highscore: isHighscore)
                    
                    TitleAnimation(type: "Mono Neutral")
                }
                
                Spacer()
                
                VStack {
                    StatBox(text: "Total trash picked:", number: appViewModel.currentScore, text2: "items")
                    HStack {
                        ItemBox(type: "Botella Aplastada", quantity: appViewModel.currentBlueBottles)
                        ItemBox(type: "Botella Torcida", quantity: appViewModel.currentGreenBottles)
                    }
                    HStack {
                        ItemBox(type: "Bolsa CONAD", quantity: appViewModel.currentOrangeBags)
                        ItemBox(type: "Lata", quantity: appViewModel.currentRedCans)
                    }
                }
                
                Spacer()
            }
        }
        .background(.teal.gradient)

    }
    
    func updateStats() {
        runs += 1
        
        total += appViewModel.currentScore
        blue += appViewModel.currentBlueBottles
        green += appViewModel.currentGreenBottles
        orange += appViewModel.currentOrangeBags
        red += appViewModel.currentRedCans
        
        if appViewModel.currentScore > highScore {
            highScore = appViewModel.currentScore
        }
    }
}

#Preview {
    EndgameView()
        .environmentObject(AppViewModel())
}
