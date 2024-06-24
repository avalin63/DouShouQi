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
    var action: () -> Void
    
    init(@ViewBuilder leading: @escaping () -> Leading, label: String, action: @escaping () -> Void = { }) {
        self.leading = leading
        self.label = label
        self.action = action
    }
    
    var body: some View {
        GenericLeftButton(
            leading: self.leading,
            label: self.label,
            backgroundColor: DSQColors.buttonBackgroundColor,
            action: self.action
        )
        
    }
}

#Preview("Light") {
    OptionsLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        }, 
        label: NSLocalizedString("statistics", comment: "Statistics"),
        action: { }
    )
}

#Preview("Dark") {
    OptionsLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        },
        label: NSLocalizedString("statistics", comment: "Statistics"),
        action: { }
    )
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
