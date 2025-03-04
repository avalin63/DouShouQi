//
//  PrimaryLeftButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct PrimaryLeftButton<Leading: View>: View {
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
            backgroundColor: DSQColors.primaryColor,
            foregroundColor: DSQColors.primaryTextButtonColor,
            action: self.action
        )
        .shadow(color: DSQColors.primaryColor.opacity(0.3), radius: 15, x: 0, y: 0)
        
    }
}


#Preview("Light") {
    PrimaryLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        },
        label: NSLocalizedString("statistics", comment: "Statistics"),
        action: { }
    )
}

#Preview("Dark") {
    PrimaryLeftButton(
        leading: {
            Image(systemName: "chart.pie.fill")
        },
        label: NSLocalizedString("statistics", comment: "Statistics"),
        action: { }
    )
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
