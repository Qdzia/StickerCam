//
//  FlashMode.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import AVFoundation
import UIKit

extension AVCaptureDevice.FlashMode {
    var image: UIImage {
        switch self {
        case .auto: return Icon.flashAuto
        case .on: return Icon.flashOn
        case .off: return Icon.flashOff
        @unknown default:
            fatalError("Flash mode is unknown")
        }
    }

    mutating func toogle() {
        let index = (self.rawValue + 1) % 3
        self = AVCaptureDevice.FlashMode(rawValue: index) ?? .auto
    }
}
