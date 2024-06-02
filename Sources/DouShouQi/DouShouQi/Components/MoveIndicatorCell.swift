//
//  MoveIndicatorCell.swift
//  DouShouQi
//
//  Created by Emre Kartal on 23/05/2024.
//

import SwiftUI

struct MoveIndicatorCell: View {
    var body: some View {
        Text(String(localized: "waiting"))
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.leading, 30)
            .padding(.trailing, 20)
            .padding(.vertical, 10)
            .background(DSQColors.moveCellBackgroundColor)
            .cornerRadius(30, corners: [.bottomLeft, .topLeft])
    }
}

#Preview {
    MoveIndicatorCell()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
