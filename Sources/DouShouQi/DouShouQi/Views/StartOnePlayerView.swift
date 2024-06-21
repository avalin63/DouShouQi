//
//  StartOnePlayerView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/05/2024.
//

import SwiftUI

struct StartOnePlayerView: View {
    @State var isConfirm = false
    @State var isReady = false
    @State var user = User()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var path: [Route]
    
    var body: some View {
        ZStack{
            VStack{
                PlayerPreparation(style: .defaultStyle, textInputStyle: TopUsernameTextInputStyle(), isReady: $isReady, username: $user.name, image: $user.image)
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
        
        .onChange(of: isConfirm) {
            if (isConfirm) {
                path.append(.game(user1: user))
            }
        }
        .onAppear {
            UINavigationBar.appearance().barTintColor = .systemRed
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview("Light") {
    StartOnePlayerView(path: State(initialValue: [Route]()).projectedValue)
}

#Preview("Dark") {
    StartOnePlayerView(path: State(initialValue: [Route]()).projectedValue)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
