//
//  StartOnePlayerView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/05/2024.
//
import SwiftUI

struct StartOnePlayerView: View {
    @State var isConfirm = false
    @State var isCustomReady = false
    @State var customUser = User()
    @State var availableUsers: [User] = []
    @State var selectedUser: User?
    @State private var selectedTab = 0

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var path: [Route]
    @EnvironmentObject var userVM: UserVM
    
    

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                PlayerPreparation(
                    style: .defaultStyle,
                    textInputStyle: TopUsernameTextInputStyle(),
                    isReady: $isCustomReady,
                    username: $customUser.name,
                    image: $customUser.image
                )
                .tag(0)
                ForEach(Array(userVM.users.enumerated()), id: \.element) { index, user in
                    VStack{
                        if var image = user.image{
                            Image(uiImage: image )
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .clipShape(Circle())
                                .frame(width: 170, height: 170)
                                .padding(.bottom, 20)
                        }
                        Text(user.name).foregroundStyle(.white)
                    }
                    .tag(index + 1)
                }
            }
            .ignoresSafeArea(.all)
            .tabViewStyle(.page)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(DSQColors.topUserContaierBackgroundColor)
            
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle().foregroundColor(DSQColors.bottomUserContainerBackgroundColor)
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.bottomPhotoPickerBackground)
                        }
                        .frame(width: 40)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    RoundedButton(
                        function: { isConfirm.toggle() },
                        systemName: "flag.checkered.2.crossed",
                        foregroundColor: DSQColors.primaryColor,
                        backgroundColor: .white
                    )
                    .opacity(selectedTab == 0 ? isCustomReady ? 1 : 0 : 1)
                    .scaleEffect(selectedTab == 0 ? isCustomReady ? 1 : 0 : 1)
                }
            }
            .padding(.horizontal, 20)
        }
        .onChange(of: selectedTab) { newValue in
            if newValue == 0 {
                selectedUser = customUser
            } else {
                selectedUser = availableUsers[newValue - 1]
            }
        }
        .onChange(of: isConfirm) { newValue in
            if newValue {
                if let userToSave = selectedUser{
                    if selectedTab == 0 {
                        userVM.saveCurrentUser(id: userToSave.id, username: userToSave.name, picture: userToSave.image)
                    }
                    path.append(.game(user1: userToSave))
                }
            }
        }
        .onChange(of:customUser){
            selectedUser = customUser
        }
        .onAppear {
            selectedUser = customUser
            availableUsers = userVM.users
            UINavigationBar.appearance().barTintColor = .systemRed
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Light") {
    StartOnePlayerView(path: .constant([Route]()))
        .environmentObject(UserVM())
}

#Preview("Dark") {
    StartOnePlayerView(path: .constant([Route]()))
        .environmentObject(UserVM())
        .preferredColorScheme(.dark)
}
