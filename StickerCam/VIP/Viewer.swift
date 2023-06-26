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

    func createButton(
        image: UIImage,
        action: Selector,
        actionEvent: UIControl.Event = .touchDown,
        tintColor: UIColor = .white,
        contentMode: UIButton.ContentMode = .scaleAspectFit
    ) -> UIButton {
        let button = UIButton()
        button.imageView?.contentMode = contentMode
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        button.addTarget(self, action: action, for: actionEvent)
        return button
    }

    func createStackView(
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = .zero,
        axis: NSLayoutConstraint.Axis = .horizontal,
        distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = alignment
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
}
