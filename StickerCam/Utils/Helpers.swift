//
//  Helpers.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            self.addSubview($0)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            self.addArrangedSubview($0)
        }
    }
}
