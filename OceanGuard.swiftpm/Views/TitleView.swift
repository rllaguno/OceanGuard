//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct TitleView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        ZStack {
            
            Image("OceanGuardTitle")
                .resizable()
                .scaledToFill()
                .frame(width: 600, height: 600)
                .offset(y: -250)
            
            VStack {
                HStack {
                    
                    MultiSpacer(quantity: 2)
                    
                    VStack {
                        MultiSpacer(quantity: 6)
                        
                        Button {
                            appViewModel.resetGame()
                            appViewModel.currentScreen = .game
                        } label: {
                            Image("StartTitle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                        }
                        
                        Button {
                            appViewModel.currentScreen = .statistics
                        } label: {
                            Image("StatsTitle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                        }
                        
                        MultiSpacer(quantity: 3)
                    }
                    
                    MultiSpacer(quantity: 2)
                    
                    VStack {
                        MultiSpacer(quantity: 1)

                        SpeechBubble(text: "Ahoy, matey! Welcome aboard Ocean Guard!", text2: "Click on me to learn the ropes!")

                        Button {
                            appViewModel.currentScreen = .tutorial
                        } label: {
                            TitleAnimation(type: "Mono Neutral")
                        }
                    }
                    .offset(x: -60, y: 60)
                    
                    MultiSpacer(quantity: 1)
                }
                
                MultiSpacer(quantity: 1)
            }
        }
        .background(.teal.gradient)
    }
}

#Preview {
    TitleView()
}
