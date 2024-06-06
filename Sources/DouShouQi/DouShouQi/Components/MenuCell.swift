//
//  MenuCell.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import SwiftUI

struct MenuCell: View {
    let label: String
    let selected: Bool
    var body: some View {
        HStack{
            selected ? Image(systemName: "checkmark") : nil
            Text(label)
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    MenuCell(label:"test", selected: true)
}
