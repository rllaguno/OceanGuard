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
            
            TutorialSpeechBubble(text: getText1(tutorialScreen: tutorialScreen), text2: getText2(tutorialScreen: tutorialScreen), length: getLength(tutorialScreen: tutorialScreen))
            
            TitleAnimation(type: getImage(tutorialScreen: tutorialScreen))
            
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
                .disabled(tutorialScreen == 6)
                
                MultiSpacer(quantity: 5)

            }
            
            Spacer()
        }
    }
    
    func getText1(tutorialScreen: Int) -> String {
        switch tutorialScreen {
        case 1:
            return "Ahoy there, recruit! Welcome aboard OceanGuard, the finest"
        case 2:
            return "But listen up matey, our beautiful oceans be in trouble! Plastic bottles, bags, and all sorts"
        case 3:
            return "We need yer help, sailor! Yer mission is simple—scoop up as much"
        case 4:
            return "Steer this fine vessel using the gyroscope."
        case 5:
            return "Keep yer eyes peeled for power-ups floatin’ in the water!"
        case 6:
            return "With yer help, we can turn the tide against ocean pollution!"
        default:
            return ""
        }
    }
    
    func getText2(tutorialScreen: Int) -> String {
        switch tutorialScreen {
        case 1:
            return " crew of ocean-cleanin' sailors this side of the seven seas!"
        case 2:
            return "o’ nasty junk be cloggin’ up the waters, harmin’ marine life and makin’ a mess of the deep blue."
        case 3:
            return "trash as ye can in 30 seconds. The more ye collect, the cleaner our seas!"
        case 4:
            return "Just tilt yer device like ye would the ship’s wheel!"
        case 5:
            return "Snatch ‘em up to boost yer ship’s speed and efficiency!"
        case 6:
            return "Now, hoist the anchor and get to work, sailor!"
        default:
            return ""
        }
    }
    
    func getImage(tutorialScreen: Int) -> String {
        switch tutorialScreen {
        case 1:
            return "Mono Neutral"
        case 2:
            return "Mono Preocupado"
        case 3:
            return "Mono Cabreado"
        case 4:
            return "Mono Sorprendido"
        case 5:
            return "Mono Sus"
        case 6:
            return "Mono Neutral"
        default:
            return "Mono Neutral"
        }
    }
    
    func getLength(tutorialScreen: Int) -> CGFloat {
        switch tutorialScreen {
        case 1:
            return 750
        case 2:
            return 1100
        case 3:
            return 850
        case 4:
            return 600
        case 5:
            return 700
        case 6:
            return 700
        default:
            return 600
        }
    }
}

#Preview {
    TutorialView()
}
