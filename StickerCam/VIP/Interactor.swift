//
//  Interactor.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import Foundation

protocol Interactable {
    associatedtype Presentable

    var presenter: Presentable? { get set }
}

class Interactor { }
