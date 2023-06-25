//
//  Router.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import Foundation

protocol Routable {
    associatedtype Viewable

    var viewController: Viewable? { get set }
}

class Router { }
