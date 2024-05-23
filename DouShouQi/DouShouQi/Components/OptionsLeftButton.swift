//
//  OptionsLeftButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct OptionsLeftButton<Leading: View>: View {
    var leading: () -> Leading
    var label: String
    
    init(@ViewBuilder leading: @escaping () -> Leading, label: String) {
        self.leading = leading
        self.label = label
    }
    
    var body: some View {
        GenericLeftButton(
            leading: self.leading,
            label: self.label,
            backgroundColor: DSQColors.buttonBackgroundColor
        )
        
    }
}

#Preview("Light") {
    OptionsLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        }, 
        label: NSLocalizedString("statistics", comment: "Statistics")
    )
}

#Preview("Dark") {
    OptionsLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        },
        label: NSLocalizedString("statistics", comment: "Statistics")
    )
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
