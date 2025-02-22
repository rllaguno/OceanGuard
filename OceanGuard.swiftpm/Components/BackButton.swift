//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(height: 50)
            
            Circle()
                .frame(height: 40)
                .foregroundStyle(.white)
            
            Image(systemName: "arrow.backward")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

#Preview {
    BackButton()
}
