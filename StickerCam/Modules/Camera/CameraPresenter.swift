//
//  CameraPresenter.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import UIKit

protocol CameraPresenterLogic {
    func askToOpenSettings()
    func askForPermisson()
    func cameraIsRunning()
    func setFlashIconTo(_ image: UIImage)
}

class CameraPresenter: Presenter, Presentable {
    weak var viewController: CameraDisplayLogic?
}

extension CameraPresenter: CameraPresenterLogic {
    func askForPermisson() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setCameraPermissionView(false)
        }
    }

    func askToOpenSettings() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showMassageToOpenSettings()
        }
    }

    func cameraIsRunning() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setCameraPermissionView(true)
            self?.viewController?.setTakePictureButton(false)
        }
    }

    func setFlashIconTo(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setFlashIcon(image)
        }
    }
}
