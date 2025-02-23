//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 23/02/25.
//

import SwiftUI

struct ImageBox: View {
    let images: [String]
    
    var body: some View {
        if images.count == 1 {
            Image(images[0])
                .resizable()
                .scaledToFit()
                .frame(width: 450)
            
        } else if images.count == 2 {
            HStack {
                Image(images[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Image(images[1])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
        } else {
            VStack {
                HStack {
                    Image(images[0])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    Image(images[1])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
                HStack {
                    Image(images[2])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    Image(images[3])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
        }
    }
}

#Preview {
    ImageBox(images: ["Botella Aplastada", "Botella Torcida", "Bolsa CONAD", "Lata"])
}
