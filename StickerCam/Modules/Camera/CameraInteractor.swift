//
//  CameraInteractor.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import Foundation

protocol CameraBusinessLogic {}

class CameraInteractor: Interactor, Interactable {
    var presenter: CameraPresenterLogic?
}
