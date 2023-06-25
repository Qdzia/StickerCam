//
//  SFIcon.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import UIKit

enum SFIcon: String {
    case settings = "gearshape.fill"
    case grid = "grid"
    case photos = "photo.on.rectangle.angled"
    case revertCamera = "arrow.triangle.2.circlepath.camera.fill"
    case flashAuto = "bolt.badge.a.fill"
    case flashOn = "bolt.fill"
    case flashOff = "bolt.slash.fill"

    var image: UIImage {
        UIImage(systemName: self.rawValue)! // swiftlint:disable:this force_unwrapping
    }
}
