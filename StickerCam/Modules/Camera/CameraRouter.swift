//
//  CameraRouter.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import Foundation

protocol CameraRoutingLogic {}

class CameraRouter: Router, Routable {
    weak var viewController: CameraViewController?
}
