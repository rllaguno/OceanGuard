//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 21/02/25.
//

import SwiftUI

struct TitleAnimation: View {
    @State private var showFirstImage = true
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(showFirstImage ? "Mono Neutral" : "Mono Sorprendido")
            .resizable()
            .scaledToFit()
            .frame(width: 350)
            .onReceive(timer) { _ in
                showFirstImage.toggle()
            }
    }
}

#Preview {
    TitleAnimation()
}
