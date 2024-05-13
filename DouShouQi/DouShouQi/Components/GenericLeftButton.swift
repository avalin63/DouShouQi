//
//  OptionsButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

import SwiftUI

struct GenericLeftButton<Leading: View, Trailing: View>: View {
    var leading: () -> Leading
    var trailing: () -> Trailing
    var label: String
    var color: Color
    
    init(@ViewBuilder leading: @escaping () -> Leading, @ViewBuilder trailing: @escaping () -> Trailing, label: String, color: Color = DSQColors.buttonbackgroundColor) {
        self.leading = leading
        self.trailing = trailing
        self.label = label
        self.color = color
    }

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 10){
                leading()
                Text(self.label)
                trailing()
                Spacer()
            }
        }
        .buttonStyle(OptionsButtonStyle(backgroundColor: color))
    }
}

#Preview("Light") {
    GenericLeftButton(leading: {
        Image(systemName: "chart.pie.fill")
    }, trailing: {
    }, label: "Statistiques", color: DSQColors.primaryColor)
}

#Preview("Dark") {
    GenericLeftButton(leading: {
        Image(systemName: "chart.pie.fill")
    }, trailing: {
    }, label: "Statistiques", color: DSQColors.primaryColor)
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
