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
            
            Image("TitleScreen")
                .resizable()
                .scaledToFill()
            
            VStack {
                HStack {
                    
                    MultiSpacer(quantity: 1)
                    
                    VStack {
                        MultiSpacer(quantity: 5)
                        
                        Button {
                            appViewModel.currentScreen = .game
                        } label: {
                            MenuButton(name: "Start Game")
                        }
                        
                        MultiSpacer(quantity: 1)

                        Button {
                            appViewModel.currentScreen = .statistics
                        } label: {
                            MenuButton(name: "Statistics")
                        }
                        
                        MultiSpacer(quantity: 3)
                    }
                    
                    MultiSpacer(quantity: 2)
                    
                    VStack {
                        MultiSpacer(quantity: 1)

                        SpeechBubble(text: "Ahoy Matey! Welcome to the Ocean Guard!", text2: "Click on me if you want to learn the ropes!")

                        Button {
                            appViewModel.currentScreen = .tutorial
                        } label: {
                            TitleAnimation()
                        }
                    }
                    
                    MultiSpacer(quantity: 1)
                }
                
                MultiSpacer(quantity: 1)
            }
        }
    }
}

#Preview {
    TitleView()
}
