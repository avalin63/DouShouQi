//
//  PreparationTwoPlayersView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct StartTwoPlayersView: View {
    @EnvironmentObject var gameVM: GameVM
    @State var isReadyFirst = false
    @State var isReadySecond = false
    @State var isConfirm = false
    
    @State private var isGameStarted = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(spacing: 0) {
                    VStack{
                        PlayerPreparation(style:.defaultStyle, textInputStyle: TopUsernameTextInputStyle(), isReady: $isReadyFirst, username: $gameVM.firstUser.name)
                    }
                    .frame(width: geo.size.width,height: geo.size.height * (1/2))
                    .background(DSQColors.topUserContaierBackgroundColor)
                    VStack{
                        PlayerPreparation(style: .variant, textInputStyle: BottomUsernameTextInputStyle(), isReady: $isReadySecond, username: $gameVM.secondUser.name)
                    }
                    .frame(width: geo.size.width,height: geo.size.height * (1/2))
                    .background(DSQColors.bottomUserContainerBackgroundColor)
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Button{
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    label: {
                        ZStack{
                            Circle().foregroundColor(DSQColors.bottomUserContainerBackgroundColor)
                            Image(systemName: "arrow.backward").foregroundColor(.bottomPhotoPickerBackground)
                        }.frame(width: 40)
                    }
                        
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                VStack(alignment: .leading){
                    Spacer()
                    HStack{
                        RoundedButton(function: {isConfirm.toggle()}, systemName: "flag.checkered.2.crossed", foregroundColor: .white, backgroundColor: DSQColors.primaryColor)
                        
                        
                            .opacity(isReadyFirst && isReadySecond ? 1 : 0)
                            .scaleEffect(isReadyFirst && isReadySecond ? 1 : 0)
                        
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear() {
            gameVM.isVersusAI = false
        }
        .onChange(of: isConfirm) {
            check()
        }
        .onChange(of: isConfirm) {
            check()
        }
        .background(
            NavigationLink(destination: GameView().navigationBarHidden(true), isActive: $isGameStarted) {
                EmptyView()
            }.navigationBarBackButtonHidden(true)
        )
    }
    
    private func check() {
        if isConfirm {
            gameVM.startGame()
            isGameStarted = true
        }
    }
}

#Preview("Light") {
    StartTwoPlayersView()
        .environmentObject(GameVM())
}

#Preview("Dark") {
    StartTwoPlayersView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(GameVM())
}
