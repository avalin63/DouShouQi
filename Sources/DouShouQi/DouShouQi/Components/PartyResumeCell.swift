//
//  PartyResumeCell.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 16/05/2024.
//

import SwiftUI

struct PartyResumeCell: View {
    var pseudo: String
    var startDate: Date?
    var endDate: Date?
    var defeatReason: String
    var playerPicture: UIImage?
        var body: some View {
        HStack{
            if let image = playerPicture {
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
                Text(pseudo)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(DSQColors.titleColor)
                Text(defeatReason)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(DSQColors.subHeadTextColor)
            }
            Spacer()
            VStack(alignment: .trailing){
                if let startingDate = startDate{
                    Text(startingDate, formatter: dateFormatter)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundStyle(DSQColors.titleColor)
                    if let endingDate = endDate{
                        Text(timeDifference(startDate: startingDate, endDate: endingDate))
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundStyle(DSQColors.subHeadTextColor)
                    }
                }
            }
        }
        .padding(15)
        .background(DSQColors.partyCellBackgroundColor)
        .border(width: 1, edges: [.top, .bottom], color: DSQColors.partyCellBorderColor)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    private func timeDifference(startDate: Date, endDate: Date) -> String {
        let difference = Calendar.current.dateComponents([.minute, .second], from: startDate, to: endDate)
        let minutes = difference.minute ?? 0
        let seconds = difference.second ?? 0
        return "\(minutes)min \(seconds)sec"
    }
}

