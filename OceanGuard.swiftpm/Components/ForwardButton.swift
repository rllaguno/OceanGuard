//
//  SwiftUIView.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SwiftUI

struct ForwardButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(height: 50)
            
            Circle()
                .frame(height: 40)
                .foregroundStyle(.white)
            
            Image(systemName: "arrow.forward")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

#Preview {
    ForwardButton()
}
