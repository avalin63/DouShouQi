//
//  StartOnePlayerView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/05/2024.
//

import SwiftUI

struct StartOnePlayerView: View {
    @EnvironmentObject var gameVM: GameVM
    @State var isConfirm = false
    @State var isReady = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            VStack{
                PlayerPreparation(style: .defaultStyle, textInputStyle: TopUsernameTextInputStyle(), isReady: $isReady, username: $gameVM.firstUser.name)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(DSQColors.topUserContaierBackgroundColor)
            
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
                    RoundedButton(function: {isConfirm.toggle()}, systemName: "flag.checkered.2.crossed", foregroundColor: DSQColors.primaryColor, backgroundColor: .white)
                .opacity(isReady ? 1 : 0)
                .scaleEffect(isReady ? 1 : 0)
                    
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear() {
            gameVM.isVersusAI = true
        }
        .background(
            NavigationLink(destination: GameView().navigationBarHidden(true), isActive: $isConfirm) {
                EmptyView()
            }
                .navigationBarBackButtonHidden(true)
        )
        .onChange(of: isConfirm) {
            gameVM.startGame()
        }
        .onAppear {
            UINavigationBar.appearance().barTintColor = .systemRed
        }
    }
}


#Preview("Light") {
    StartOnePlayerView()
        .environmentObject(GameVM())
}

#Preview("Dark") {
    StartOnePlayerView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(GameVM())
}
