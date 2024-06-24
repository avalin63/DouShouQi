//
//  OptionsButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import SwiftUI

struct OptionsButton: View {
    let imageSystem: String
    let label: String
    @Binding var toggler: Bool
    var selected: String
    var body: some View {
        Button(action: {
            toggler.toggle()
        }) {
            HStack{
                Image(systemName: imageSystem)
                Text(label)
                Spacer()
                Text(selected)
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .foregroundStyle(DSQColors.buttonOptionsForegroundColor)
            .background(DSQColors.buttonOptionsBackgroundColor)
        }
    }
}
