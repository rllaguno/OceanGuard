//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject var appViewModel: AppViewModel // Use EnvironmentObject

    var scene: SKScene {
        let scene = GameScene()
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .aspectFill
        scene.appViewModel = appViewModel
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}


#Preview {
    GameView()
        .environmentObject(AppViewModel())
}
