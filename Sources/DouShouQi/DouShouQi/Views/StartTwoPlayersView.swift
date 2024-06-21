//
//  PreparationTwoPlayersView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct StartTwoPlayersView: View {
    @State var isReadyFirst = false
    @State var isReadySecond = false
    @State var isConfirm = false
    @State var firstUser = User()
    @State var secondUser = User()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var path: [Route]
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(spacing: 0) {
                    VStack{
                        PlayerPreparation(style:.defaultStyle, textInputStyle: TopUsernameTextInputStyle(), isReady: $isReadyFirst, username: $firstUser.name, image: $firstUser.image)
                    }
                    .frame(width: geo.size.width,height: geo.size.height * (1/2))
                    .background(DSQColors.topUserContaierBackgroundColor)
                    VStack{
                        PlayerPreparation(style: .variant, textInputStyle: BottomUsernameTextInputStyle(), isReady: $isReadySecond, username: $secondUser.name, image: $secondUser.image)
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
        .onChange(of: isConfirm) {
            if isConfirm {                
                path.append(.game(user1: firstUser, user2: secondUser))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Light") {
    StartTwoPlayersView(path: State(initialValue: [Route]()).projectedValue)
}

#Preview("Dark") {
    StartTwoPlayersView(path: State(initialValue: [Route]()).projectedValue)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
