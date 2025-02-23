//
//  File.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import Foundation

enum Screen {
    case title
    case tutorial
    case statistics
    case game
    case endgame
}

class AppViewModel: ObservableObject {
    //The current screen of the application
    @Published var currentScreen: Screen = .title
    // Current score of game
    @Published var currentScore: Int = 0
    //Current Blue Plastic Bottles
    @Published var currentBlueBottles: Int = 0
    //Current Green Plastic Bottles
    @Published var currentGreenBottles: Int = 0
    //Current Orange Plastic Bags
    @Published var currentOrangeBags: Int = 0
    //Current Blue Red Cans
    @Published var currentRedCans: Int = 0
    
    func resetGame() {
        currentScore = 0
        currentGreenBottles = 0
        currentRedCans = 0
        currentBlueBottles = 0
        currentOrangeBags = 0
    }
    
}
