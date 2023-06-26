//
//  TitleSection.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import UIKit

class TitleSection: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .title
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .body
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubviews([titleLabel, detailLabel])
        setTextColor(to: .black)
        snapLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTextColor(to color: UIColor) {
        titleLabel.textColor = color
        detailLabel.textColor = color
    }

    func setText(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }

    private func snapLayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Design.paddingMedium)
            make.right.equalToSuperview().inset(Design.paddingMedium)
            make.top.equalToSuperview()
        }

        detailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Design.paddingMedium)
            make.right.equalToSuperview().inset(Design.paddingMedium)
            make.top.equalTo(titleLabel.snp.bottom).offset(Design.spaceBetween)
            make.bottom.equalToSuperview()
        }
    }
}

fileprivate extension Design {
    static let spaceBetween = 24.0
}
