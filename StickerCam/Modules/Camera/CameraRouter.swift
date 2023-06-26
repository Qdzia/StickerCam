//
//  CameraRouter.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import UIKit

@objc
protocol CameraRoutingLogic {
    func navigateToEditor(with image: UIImage)
}

class CameraRouter: Router, Routable {
    weak var viewController: CameraViewController?
}

extension CameraRouter: CameraRoutingLogic {
    func navigateToEditor(with image: UIImage) {}
}
