//
//  OptionsLeftButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct OptionsLeftButton<Leading: View, Destination: View>: View {
    var leading: () -> Leading
    var label: String
    var destination: () -> Destination
    
    init(@ViewBuilder leading: @escaping () -> Leading, label: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.leading = leading
        self.label = label
        self.destination = destination
    }
    
    var body: some View {
        GenericLeftButton(
            leading: self.leading,
            label: self.label,
            backgroundColor: DSQColors.buttonBackgroundColor,
            destination: self.destination
        )
        
    }
}

#Preview("Light") {
    OptionsLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        }, 
        label: NSLocalizedString("statistics", comment: "Statistics"),
        destination: { StartGameView() }
    )
}

#Preview("Dark") {
    OptionsLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        },
        label: NSLocalizedString("statistics", comment: "Statistics"),
        destination: { StartGameView() }
    )
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
