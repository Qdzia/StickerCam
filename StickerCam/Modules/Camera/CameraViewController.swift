//
//  CameraViewController.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import AVFoundation
import SnapKit
import UIKit

protocol CameraDisplayLogic: AnyObject {
    func setCameraPermissionView(_ hidden: Bool)
    func setTakePictureButton(_ hidden: Bool)
    func setFlashIcon(_ image: UIImage)
    func showMassageToOpenSettings()
}

class CameraViewController: Viewer, Viewable {
    var interactor: CameraBusinessLogic?
    var router: CameraRoutingLogic?

    private let cameraPermissionView = CameraPermissionView()
    private let gridView = GridView()
    private let topToolBar = UIView()
    private var userDeniedAccessToCamera = false
    private lazy var topToolBarGroup = createStackView(spacing: Design.toolBarIconSpacing)
    private lazy var bottomToolBar = createStackView(
        alignment: .fill,
        spacing: Design.toolBarSpacing,
        distribution: .equalSpacing
    )

    private lazy var takePictureButton = createButton(image: Icon.shutter, action: #selector(takePhoto))
    private lazy var settingsButton = createButton(image: Icon.settings, action: #selector(openSettings))
    private lazy var revertButton = createButton(image: Icon.revertCamera, action: #selector(revertCamera))
    private lazy var flashButton = createButton(image: Icon.flashAuto, action: #selector(switchFlashMode))
    private lazy var gridButton = createButton(image: Icon.grid, action: #selector(showGrid))
    private lazy var filtersButton = createButton(image: Icon.filters, action: #selector(openFilters))
    private lazy var photosButton = createButton(image: Icon.photos, action: #selector(openPhotos))

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func setupViews() {
        topToolBarGroup.addArrangedSubviews([filtersButton, flashButton, gridButton])
        topToolBar.addSubviews([settingsButton, topToolBarGroup])
        bottomToolBar.addArrangedSubviews([photosButton, revertButton])
        view.addSubviews([topToolBar, bottomToolBar, cameraPermissionView, takePictureButton, gridView])
        view.backgroundColor = .black

        [gridView, cameraPermissionView, takePictureButton].forEach {
            $0.isHidden = true
        }

        #if targetEnvironment(simulator)
        [flashButton, gridButton, revertButton, filtersButton].forEach({
            $0.isEnabled = false
        })
        #endif

        interactor?.setCameraPreviewFrame(view: cameraPermissionView)
        interactor?.startCameraIfHavePermission(delegate: self, displayBelow: takePictureButton.layer)
    }

    override func snapLayout() {
        settingsButton.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
        }

        topToolBarGroup.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
        }

        topToolBar.snp.makeConstraints { make in
            make.left.top.equalTo(view.safeAreaLayoutGuide).offset(Design.toolBarPadding)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(Design.toolBarPadding)
            make.height.equalTo(Design.toolBarHeight)
        }

        bottomToolBar.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).inset(Design.toolBarPadding)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(Design.toolBarPadding)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Design.toolBarPaddingBottom)
            make.height.equalTo(Design.toolBarHeightLarge)
        }

        cameraPermissionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topToolBar.snp.bottom)
            make.bottom.equalTo(bottomToolBar.snp.top)
        }

        takePictureButton.snp.makeConstraints { make in
            make.bottom.equalTo(bottomToolBar.snp.top).inset(-Design.paddingSmall)
            make.centerX.equalToSuperview()
        }

        takePictureButton.imageView?.snp.makeConstraints { make in
            make.width.height.equalTo(Design.shutterButtonHeight)
        }

        gridView.snp.makeConstraints { make in
            make.edges.equalTo(cameraPermissionView)
        }

        [filtersButton, photosButton, settingsButton, gridButton, flashButton, revertButton].forEach { button in
            button.imageView?.snp.makeConstraints { make in
                make.width.height.equalTo(Design.actionButtonHeight)
            }
        }
    }

    @objc
    private func grantPermissionOrOpenSettings() {
        if userDeniedAccessToCamera {
            interactor?.openSettings()
        } else {
            interactor?.startCameraAndAskForPermission(delegate: self, displayBelow: takePictureButton.layer)
        }
    }

    @objc
    private func takePhoto() {
        // TODO: Add loader
        interactor?.capturePhoto(with: self)
    }

    @objc
    private func revertCamera() {
        interactor?.revertCamera()
    }

    @objc
    private func showGrid() {
        view.insertSubview(gridView, belowSubview: takePictureButton)
        gridView.isHidden.toggle()
    }

    @objc
    private func switchFlashMode() {
        interactor?.switchFlashMode()
    }

    @objc
    private func openSettings() {}

    @objc
    private func openPhotos() {}

    @objc
    private func openFilters() {}
}

extension CameraViewController: CameraDisplayLogic {
    func setCameraPermissionView(_ hidden: Bool) {
        cameraPermissionView.isHidden = hidden
    }

    func setTakePictureButton(_ hidden: Bool) {
        takePictureButton.isHidden = hidden
    }

    func setFlashIcon(_ image: UIImage) {
        flashButton.setImage(image, for: .normal)
    }

    func showMassageToOpenSettings() {
        cameraPermissionView.showOpenSettingsMassageAndButton()
        userDeniedAccessToCamera = true
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        guard let image = previewImage else { return }
        UIApplication.shared.isIdleTimerDisabled = false
        // TODO: Add loader
        router?.navigateToEditor(with: image)
    }
}

fileprivate extension Design {
    static let toolBarHeight = 32.0
    static let toolBarHeightLarge = 40.0
    static let toolBarPadding = 24.0
    static let toolBarPaddingBottom = 8.0
    static let toolBarIconSpacing: CGFloat = 32.0
    static let toolBarSpacing: CGFloat = 12.0
    static let shutterMarginBottom = 40.0
    static let shutterButtonHeight = 96.0
    static let actionButtonHeight = 32.0
}
