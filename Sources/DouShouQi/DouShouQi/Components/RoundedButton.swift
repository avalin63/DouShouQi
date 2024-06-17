//
//  RoundedButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 03/06/2024.
//

import SwiftUI

struct RoundedButton: View {
    let function: () -> Void
    let systemName: String
    let foregroundColor: Color
    let backgroundColor: Color
    var body: some View {
        Button{
            function()
        }
        label: {
            ZStack{
            Circle().foregroundColor(backgroundColor)
            Image(systemName: systemName)
                    .foregroundColor(foregroundColor)
        }
        .frame(width: 40)
        }
    }
}

#Preview {
    RoundedButton(function: {}, systemName: "flag.checkered.2.crossed", foregroundColor: .red, backgroundColor: .blue)
}
