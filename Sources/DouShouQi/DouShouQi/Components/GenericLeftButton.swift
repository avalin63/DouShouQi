//
//  OptionsButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct GenericLeftButton<Leading: View>: View {
    var leading: () -> Leading
    var label: String
    var backgroundColor: Color
    var foregroundColor: Color
    var action: () -> Void
    
    @State private var isExpanded = false
    
    init(@ViewBuilder leading: @escaping () -> Leading, label: String, backgroundColor: Color = DSQColors.buttonBackgroundColor, foregroundColor: Color = DSQColors.buttonTextColor, action: @escaping () -> Void) {
        self.leading = leading
        self.label = label
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                leading().frame(width: 40, alignment: .trailing)
                Text(self.label)
                Spacer()
            }
        }
        .buttonStyle(LeftButtonStyle(backgroundColor: backgroundColor, foregroundColor: foregroundColor, isExpanded: isExpanded))
        .onLongPressGesture(
            minimumDuration: 0.5,
            pressing: { isPressing in
                withAnimation {
                    isExpanded = isPressing
                }
            },
            perform: {
            }
        )
    }
}

