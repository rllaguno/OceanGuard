//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 21/02/25.
//

import SwiftUI

struct TitleAnimation: View {
    var type: String
    
    @State private var showFirstImage = true
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if type == "Mono Neutral" {
            Image(showFirstImage ? "Mono Neutral" : "Mono Sorprendido")
                .resizable()
                .scaledToFit()
                .frame(width: 350)
                .onReceive(timer) { _ in
                    showFirstImage.toggle()
                }
        } else {
            Image(showFirstImage ? type : "Mono Neutral")
                .resizable()
                .scaledToFit()
                .frame(width: 350)
                .onReceive(timer) { _ in
                    showFirstImage.toggle()
                }
        }
    }
}

#Preview {
    TitleAnimation(type: "Mono Neutral")
}
