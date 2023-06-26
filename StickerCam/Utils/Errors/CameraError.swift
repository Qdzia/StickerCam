//
//  CameraError.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import Foundation

enum CameraError: Error, LocalizedError {
    case noCameraFound
    case cannotCreateDevice
    case cannotAddInputToSession
    case cannotAddOutputVideo

    var errorDescription: String? {
        switch self {
        case .noCameraFound: return "Cannot find camera device for given parameters"
        case .cannotCreateDevice: return "Could not create input device from camera"
        case .cannotAddInputToSession: return "Could not add camera input to capture session"
        case .cannotAddOutputVideo: return "Could not add camera output to capture session"
        }
    }
}
