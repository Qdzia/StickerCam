//
//  StandardButton.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import UIKit

enum ButtonStyle {
    case color, transparent
}

final class StandardButton: UIButton {
    var buttonStyle: ButtonStyle = .color {
        didSet { renderView() }
    }

    override var isEnabled: Bool {
        didSet { renderView() }
    }

    init(title: String, buttonStyle: ButtonStyle) {
        super.init(frame: .zero)
        self.buttonStyle = buttonStyle
        setTitle(title, for: .normal)
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = Design.cornerRadius
        titleLabel?.font = .body
    }

    private func renderView() {
        switch buttonStyle {
        case .color:
            backgroundColor = isEnabled ? .yellow : .gray

        case .transparent:
            backgroundColor = nil
        }
    }
}
