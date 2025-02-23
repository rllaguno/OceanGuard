import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        switch appViewModel.currentScreen {
        case .title:
            TitleView()
        case .tutorial:
            TutorialView()
        case .statistics:
            StatisticsView()
        case .game:
            GameView()
        case .endgame:
            EndgameView()
        }
    }
}
