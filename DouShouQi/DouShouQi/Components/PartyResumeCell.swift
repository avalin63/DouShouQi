//
//  PartyResumeCell.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 16/05/2024.
//

import SwiftUI

struct PartyResumeCell: View {
    var body: some View {
        HStack{
            Image(.template)
              .resizable()
              .frame(width: 50, height: 50)
              .foregroundColor(.white)
              .clipShape(Circle())
            VStack(alignment: .leading){
                Text("Pseudo")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(DSQColors.titleColor)
                Text("Winning reason")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(DSQColors.subHeadTextColor)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("11/05/2024")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(DSQColors.titleColor)
                Text("12min34s")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(DSQColors.subHeadTextColor)
            }
        }
        .padding(15)
        .background(DSQColors.partyCellBackgroundColor)
        .border(width: 1, edges: [.top, .bottom], color: DSQColors.partyCellBorderColor)
    }
}

#Preview {
    PartyResumeCell()
}
