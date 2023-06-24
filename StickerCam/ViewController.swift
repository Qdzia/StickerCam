//
//  ViewController.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 24/06/2023.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Welcome to StickerCam!"
        label.textAlignment = .center
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
