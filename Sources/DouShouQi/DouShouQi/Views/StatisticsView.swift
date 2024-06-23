//
//  StatisticsView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/06/2024.
//

import SwiftUI

struct StatisticsView: View {
    @Binding var path: [Route]
    @EnvironmentObject var historicVM: HistoricVM
    @EnvironmentObject var userVM: UserVM
    
    var body: some View {
        let statistics = historicVM.getWinLossStatistics()
        let statsArray = Array(statistics)
        VStack(alignment: .leading){
            Text(String(localized: "statistics"))
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(DSQColors.titleColor)
                .padding(.horizontal, 30)
            ScrollView{
                ForEach(statsArray, id: \.key) { userId, stat in
                    if let user = userVM.getUser(by:userId){
                        StatisticsCell(user: user, losses: stat.losses, wins: stat.wins)

                    }
                }
                
            }
        }
    }
}

#Preview {
    StatisticsView(path: State(initialValue: [Route]()).projectedValue)
}
