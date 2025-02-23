//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct ItemBox: View {
    let type: String
    let quantity: Int
    var title: String {
        if type == "Bolsa CONAD" {
            return "Orange Bags:"
        } else  if type == "Botella Aplastada" {
            return "Green Bottles:"
        } else if type == "Lata" {
            return "Red Cans:"
        } else {
            return "Blue Bottles:"
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black)
                .frame(width: 150, height: 120)
                .cornerRadius(20)

            Rectangle()
                .foregroundStyle(Color.white)
                .frame(width: 140, height: 110)
                .cornerRadius(20)
            
            Text(title)
                .offset(y: -20)
                .font(.system(size: 18))
                .foregroundStyle(.black)

            HStack {
                Text(String(quantity))
                    .offset(y: 20)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.black)
                Image(type)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .offset(x: 5, y: 18)
            }
        }
    }
}

#Preview {
    ItemBox(type: "Bolsa CONAD", quantity: 5)
}
