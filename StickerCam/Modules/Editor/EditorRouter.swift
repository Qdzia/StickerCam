//
//  EditorRouter.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import Foundation

protocol EditorRoutingLogic {}

class EditorRouter: Router, Routable {
    weak var viewController: EditorViewController?
}
