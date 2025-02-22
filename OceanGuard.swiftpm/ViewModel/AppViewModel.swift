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
    
}
