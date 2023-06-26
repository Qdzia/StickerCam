//
//  EditorInteractor.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import Foundation

protocol EditorBusinessLogic {}

class EditorInteractor: Interactor, Interactable {
    var presenter: EditorPresenterLogic?
}
