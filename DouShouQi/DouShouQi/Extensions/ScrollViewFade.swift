//
//  ScrollViewFade.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 16/05/2024.
//

import SwiftUI

extension View {
    func fadeOutTop(fadeLength:CGFloat=50) -> some View {
        return mask(
            VStack(spacing: 0) {

                // Top gradient
                LinearGradient(gradient:
                   Gradient(
                       colors: [Color.black.opacity(0), Color.black]),
                       startPoint: .top, endPoint: .bottom
                   )
                   .frame(height: fadeLength)
                
                Rectangle().fill(Color.black)
            }
        )
    }
}

