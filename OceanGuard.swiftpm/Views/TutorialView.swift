//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    @State private var tutorialScreen: Int = 1
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                MultiSpacer(quantity: 1)

                Button {
                    appViewModel.currentScreen = .title
                } label: {
                    BackButton()
                }
                .buttonStyle(.plain)
                
                MultiSpacer(quantity: 10)

            }
            
            MultiSpacer(quantity: 1)
            
            SpeechBubble(text: getText1(tutorialScreen: tutorialScreen), text2: getText2(tutorialScreen: tutorialScreen))
            
            TitleAnimation()
            
            Spacer()
            
            HStack {
                MultiSpacer(quantity: 5)
                
                Button {
                    tutorialScreen -= 1
                } label: {
                    BackButton()
                }
                .disabled(tutorialScreen == 1)
                
                Spacer()
                
                Text(String(tutorialScreen))
                    .font(.system(size: 32, weight: .bold))
                
                Spacer()
                
                Button {
                    tutorialScreen += 1
                } label: {
                    ForwardButton()
                }
                MultiSpacer(quantity: 5)

            }
        }
    }
    
    func getText1(tutorialScreen: Int) -> String {
        switch tutorialScreen {
        case 1:
            return "Welcome to Ocean Guard where we protect"
        case 2:
            return ""
        case 3:
            return ""
        case 4:
            return ""
        case 5:
            return ""
        default:
            return ""
        }
    }
    
    func getText2(tutorialScreen: Int) -> String {
        switch tutorialScreen {
        case 1:
            return "the ocean, its wildlife and ecosystem!"
        case 2:
            return ""
        case 3:
            return ""
        case 4:
            return ""
        case 5:
            return ""
        default:
            return ""
        }
    }
}

#Preview {
    TutorialView()
}
