//
//  Viewer.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import UIKit

protocol Viewable {
    associatedtype Interactable
    associatedtype Routable
    
    var interactor: Interactable? { get set }
    var router: Routable? { get set }
}

class Viewer: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        snapLayout()
    }

    func setupViews() { }
    func snapLayout() { }
}
