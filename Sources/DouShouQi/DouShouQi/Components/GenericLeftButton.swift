//
//  OptionsButton.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct GenericLeftButton<Leading: View, Destination: View>: View {
    var leading: () -> Leading
    var label: String
    var backgroundColor: Color
    var foregroundColor: Color
    var destination: () -> Destination
    
    @State private var isExpanded = false
    @State private var navigate = false
    
    init(@ViewBuilder leading: @escaping () -> Leading, label: String, backgroundColor: Color = DSQColors.buttonBackgroundColor, foregroundColor: Color = DSQColors.buttonTextColor, @ViewBuilder destination: @escaping () -> Destination) {
        self.leading = leading
        self.label = label
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination(), isActive: $navigate) {
            Button(action: {
                navigate = true
            }) {
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
}

