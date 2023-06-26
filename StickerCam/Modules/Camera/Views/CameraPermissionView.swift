//
//  CameraPermissionView.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import UIKit

class CameraPermissionView: UIView {
    private let titleSection: TitleSection = {
        let titleSection = TitleSection()
        titleSection.setTextColor(to: .white)
        titleSection.setText(
            title: "camera_access_title".localized,
            detail: "camera_access_detail".localized
        )
        return titleSection
    }()

    private let accessDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .body
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.text = "camera_access_description".localized
        label.textColor = .blue
        return label
    }()

    private let permissionButton = StandardButton(title: "camera_access_grant".localized, buttonStyle: .color)

    init() {
        super.init(frame: .zero)
        setUpViews()
        snapLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        addSubviews([titleSection, permissionButton, accessDescription])
        accessDescription.isHidden = true
        #if targetEnvironment(simulator)
        permissionButton.isEnabled = false
        #endif
    }

    private func snapLayout() {
        titleSection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(Design.titleOffSet)
        }

        permissionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Design.paddingLarge)
            make.left.equalToSuperview().offset(Design.paddingMedium)
            make.right.equalToSuperview().inset(Design.paddingMedium)
            make.height.equalTo(Design.buttonHeight)
        }

        accessDescription.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Design.paddingMedium)
            make.right.equalToSuperview().inset(Design.paddingMedium)
            make.bottom.equalTo(permissionButton.snp.top).inset(-Design.paddingSmall)
        }
    }

    func showOpenSettingsMassageAndButton() {
        permissionButton.setTitle("camera_access_open_settings".localized, for: .normal)
        accessDescription.isHidden = false
    }

    func addAction(_ target: Any?, _ selector: Selector) {
        permissionButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}

fileprivate extension Design {
    static let titleOffSet = 24.0
}
