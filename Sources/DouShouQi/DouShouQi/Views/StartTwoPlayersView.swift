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
    @State var customFirstUser = User()
    @State var customSecondUser = User()
    @State var showError = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var path: [Route]
    @EnvironmentObject var userVM: UserVM
    
    @State private var selectedFirstUser: User?
    @State private var selectedSecondUser: User?
    @State private var selectedTabTop = 0
    @State private var selectedTabBottom = 0
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(spacing: 0) {
                    TabView(selection: $selectedTabTop) {
                        PlayerPreparation(
                            style: .defaultStyle,
                            textInputStyle: TopUsernameTextInputStyle(),
                            isReady: $isReadyFirst,
                            username: $customFirstUser.name,
                            image: $customFirstUser.image
                        )
                        .tag(0)
                        
                        ForEach(Array(userVM.users.enumerated()), id: \.element) { index, user in
                            VStack {
                                if let image = user.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .frame(width: 170, height: 170)
                                        .padding(.bottom, 20)
                                }
                                Text(user.name)
                                    .foregroundStyle(.white)
                            }
                            .tag(index + 1)
                        }
                    }
                    .ignoresSafeArea(.all)
                    .tabViewStyle(.page)
                    .frame(width: geo.size.width,height: geo.size.height * (1/2))
                    .background(DSQColors.topUserContaierBackgroundColor)
                    TabView(selection: $selectedTabBottom) {
                        PlayerPreparation(
                            style: .defaultStyle,
                            textInputStyle: TopUsernameTextInputStyle(),
                            isReady: $isReadySecond,
                            username: $customSecondUser.name,
                            image: $customSecondUser.image
                        )
                        .tag(0)
                        
                        ForEach(Array(userVM.users.enumerated()), id: \.element) { index, user in
                            VStack {
                                if let image = user.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .frame(width: 170, height: 170)
                                        .padding(.bottom, 20)
                                }
                                Text(user.name)
                                    .foregroundStyle(.white)
                            }
                            .tag(index + 1)
                        }
                    }
                    .ignoresSafeArea(.all)
                    .tabViewStyle(.page)
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
                        
                        
                            .opacity(isReadyFirst && isReadySecond ? 1 : 0 )
                            .scaleEffect(isReadyFirst && isReadySecond ? 1 : 0 )
                        
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onChange(of: selectedTabTop) { newValue in
            if newValue == 0 {
                selectedFirstUser = customFirstUser
                if(customFirstUser.image != nil && customFirstUser.name.count != 0){
                    isReadyFirst = true
                }
                else{
                    isReadyFirst = false
                }
            } else {
                selectedFirstUser = userVM.users[newValue - 1]
                isReadyFirst = true
            }
            checkIfSameUser()
        }
        .onChange(of: selectedTabBottom) { newValue in
            if newValue == 0 {
                selectedSecondUser = customSecondUser
                if(customSecondUser.image != nil && customSecondUser.name.count != 0){
                    isReadySecond = true
                }
                else{
                    isReadySecond = false
                }
            } else {
                selectedSecondUser = userVM.users[newValue - 1]
                isReadySecond = true
            }
            checkIfSameUser()
        }
        .onChange(of:customFirstUser){
            selectedFirstUser = customFirstUser
        }
        .onChange(of:customSecondUser){
            selectedSecondUser = customSecondUser
        }
        .onChange(of: isConfirm) { newValue in
            if newValue {
                if let firstUser = selectedFirstUser{
                    if selectedTabTop == 0 {
                        userVM.saveCurrentUser(id: firstUser.id, username: firstUser.name, picture: firstUser.image)
                    }
                    
                }
                if let secondUser = selectedSecondUser {
                    if selectedTabBottom == 0 {
                        userVM.saveCurrentUser(id: secondUser.id, username: secondUser.name, picture: secondUser.image)
                    }
                }
                if let firstUser = selectedFirstUser, let secondUser = selectedSecondUser {
                    if firstUser.id != secondUser.id {
                        path.append(.game(user1: firstUser, user2: secondUser))
                    } else {
                        showError = true
                    }
                }
            }
        }
        .onAppear {
            selectedFirstUser = customFirstUser
            selectedSecondUser = customSecondUser
            UINavigationBar.appearance().barTintColor = .systemRed
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text("The two players cannot be the same."), dismissButton: .default(Text("OK")))
        }
    }
    
    private func checkIfSameUser() {
        if let firstUser = selectedFirstUser, let secondUser = selectedSecondUser, firstUser.id == secondUser.id {
            showError = true
            isReadyFirst = false
            isReadySecond = false
        } else {
            showError = false
        }
    }
}

#Preview("Light") {
    StartTwoPlayersView(path: State(initialValue: [Route]()).projectedValue)
        .environmentObject(UserVM())
}

#Preview("Dark") {
    StartTwoPlayersView(path: State(initialValue: [Route]()).projectedValue)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(UserVM())
}
