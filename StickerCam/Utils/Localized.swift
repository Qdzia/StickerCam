//
//  Localized.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
