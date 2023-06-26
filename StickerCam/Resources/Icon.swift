//
//  Icon.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import UIKit

enum Icon {
    static let shutter = image("circle.inset.filled")
    static let settings = image("gearshape.fill")
    static let grid = image("grid")
    static let photos = image("photo.on.rectangle.angled")
    static let filters = image("camera.filters")
    static let revertCamera = image("arrow.triangle.2.circlepath.camera.fill")
    static let flashAuto = image("bolt.badge.a.fill")
    static let flashOn = image("bolt.fill")
    static let flashOff = image("bolt.slash.fill")

    private static func image(_ systemName: String) -> UIImage {
        UIImage(systemName: systemName)! // swiftlint:disable:this force_unwrapping
    }
}
