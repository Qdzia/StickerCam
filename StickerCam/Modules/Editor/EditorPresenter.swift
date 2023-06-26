//
//  EditorPresenter.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import Foundation

protocol EditorPresenterLogic {}

class EditorPresenter: Presenter, Presentable {
    weak var viewController: EditorDisplayLogic?
}
