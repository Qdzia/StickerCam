//
//  CameraPresenter.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import Foundation

protocol CameraPresenterLogic {}

class CameraPresenter: Presenter, Presentable {
    weak var viewController: CameraDisplayLogic?
}
