//
//  StatisticsCell.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 23/06/2024.
//

import SwiftUI

struct StatisticsCell: View {
    var user: User
    var losses: Int
    var wins: Int
    var body: some View {
        HStack(spacing: 0){
            HStack{
                if let image = user.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                } else {
                    Image(.template)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading){
                    Text(user.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(DSQColors.titleColor)
                }}.padding(15)
            Spacer()
            HStack(spacing: 0){
                VStack(alignment: .center){
                    
                    Text(losses.description)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text(String(localized: "Losses"))
                        .lineLimit(1)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }        .padding(15).frame(width: 100).background(.black)
                VStack(alignment: .center){
                    Text(wins.description)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text(String(localized: "Wins"))
                        .lineLimit(1)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }        .padding(15).frame(width: 100).background(DSQColors.primaryColor)
            }.frame(height: .infinity)
        }
        .background(DSQColors.partyCellBackgroundColor)
        .border(width: 1, edges: [.top, .bottom], color: DSQColors.partyCellBorderColor)
    }
    
}

