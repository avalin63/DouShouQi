//
//  OptionsView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import SwiftUI

struct OptionsView: View {
    @State private var showPopoverLangues: Bool = false
    @State private var showPopoverThemes: Bool = false
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var languageManager: LanguageManager
    private let selectionLang: [Language] = [
        .en,
        .fr
    ]
    private let selectionTheme: [Theme] = [
        Theme.dark,
        Theme.light,
        Theme.systemdefault
    ]
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text(String(localized: "Options")).bold().font(.title2)
                    Spacer()
                }
                VStack(spacing: 0){
                    Menu{
                        ForEach(selectionLang, id: \.self) {option in
                            Button{
                                languageManager.selectedLang = option
                            } label: {
                                MenuCell(label: option.description, selected: option.description == languageManager.selectedLang.description)
                            }
                            
                        }
                    } label: {
                        OptionsButton(imageSystem: "globe", label: String(localized: "Language"), toggler: $showPopoverLangues, selected: languageManager.selectedLang.description)
                    }
                    Menu{
                        ForEach(selectionTheme, id: \.self) {option in
                            Button{
                                themeManager.selectedTheme = option
                            } label: {
                                MenuCell(label: option.description, selected: option.description == themeManager.selectedTheme.description)
                            }
                        }
                    } label: {
                        OptionsButton(imageSystem: "sun.min.fill", label: String(localized: "Options"), toggler: $showPopoverThemes, selected: themeManager.selectedTheme.description)
                        
                    }
                }.cornerRadius(8, corners: .allCorners)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 30)
        }
        .background(DSQColors.backgroundColor)
    }
}

struct OptionsView_Previews: PreviewProvider {
        static var previews: some View {
            @StateObject var themeManager = ThemeManager()
            @StateObject var languageManager = LanguageManager()

            OptionsView()
                .environmentObject(themeManager)
                .environmentObject(languageManager)

        }

    }
