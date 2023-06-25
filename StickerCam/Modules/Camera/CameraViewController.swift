//
//  CameraViewController.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import SnapKit
import UIKit

protocol CameraDisplayLogic: AnyObject {}

class CameraViewController: Viewer, Viewable {
    var interactor: CameraBusinessLogic?
    var router: CameraRoutingLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Welcome to StickerCam!"
        label.textAlignment = .center
        view.backgroundColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
