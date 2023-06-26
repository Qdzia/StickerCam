//
//  EditorViewController.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import SnapKit
import UIKit

protocol EditorDisplayLogic: AnyObject {}

class EditorViewController: Viewer, Viewable {
    var interactor: EditorBusinessLogic?
    var router: EditorRoutingLogic?

    override func setupViews() {
        let label = UILabel()
        label.text = "Editor screen"
        label.textAlignment = .center
        view.addSubview(label)
        view.backgroundColor = .white

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
