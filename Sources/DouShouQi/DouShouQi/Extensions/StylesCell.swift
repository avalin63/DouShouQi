//
//  StylesCell.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 31/05/2024.
//

import SwiftUI


extension PlayerPreparationStyle {
    static let defaultStyle = PlayerPreparationStyle(
        picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor,
        picturePickerForeground: DSQColors.topPhotoPickerForegroundColor,
        checkMarkColor: .white
    )
    
    static let variant = PlayerPreparationStyle(
        picturePickerBackground: DSQColors.bottomPhotoPickerBackgroundColor,
        picturePickerForeground: DSQColors.bottomPhotoPickerForegroundColor,
        checkMarkColor: DSQColors.primaryColor
    )
}
