//
//  CameraInteractor.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import AVFoundation
import UIKit

enum CameraDevice {
    case front, back
}

protocol CameraBusinessLogic {
    func startCameraIfHavePermission(delegate: UIViewController, displayBelow layer: CALayer)
    func startCameraAndAskForPermission(delegate: UIViewController, displayBelow layer: CALayer)
    func capturePhoto(with delegate: AVCapturePhotoCaptureDelegate)
    func setCameraPreviewFrame(view: UIView)
    func switchFlashMode()
    func openSettings()
    func revertCamera()
}

class CameraInteractor: Interactor, Interactable {
    var presenter: CameraPresenterLogic?

    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    private var cameraView: UIView?
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var flashMode = AVCaptureDevice.FlashMode.auto
    private var cameraDevice = CameraDevice.back
    private var frontInputDevice: AVCaptureDeviceInput?
    private var backInputDevice: AVCaptureDeviceInput?
    private var isPermissionGranted: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    private func setUpAndStartCamera(delegate: UIViewController, displayBelow layer: CALayer) {
        captureSession.beginConfiguration()
        if captureSession.canSetSessionPreset(.photo) {
            captureSession.sessionPreset = .photo
        }
        captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        do {
            try setupInputs()
        } catch {
            Log.error(error)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.setupPreviewLayer(with: delegate, below: layer)
        }
        do {
            try setupOutput()
        } catch {
            Log.error(error)
            return
        }
        captureSession.commitConfiguration()
        captureSession.startRunning()
        presenter?.cameraIsRunning()
        UIApplication.shared.isIdleTimerDisabled = true
    }

    private func setupPreviewLayer(with viewController: UIViewController, below layer: CALayer) {
        previewLayer.frame = cameraView?.frame ?? .zero
        previewLayer.videoGravity = .resizeAspect
        previewLayer.connection?.videoOrientation = .portrait
        viewController.view.layer.insertSublayer(previewLayer, below: layer)
    }

    private func setupInputs() throws {
        let backDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        let frontDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        guard let backCamera = backDevice else { throw CameraError.noCameraFound }
        guard let frontCamera = frontDevice else { throw CameraError.noCameraFound }

        guard let backInput = try? AVCaptureDeviceInput(device: backCamera) else {
            throw CameraError.cannotCreateDevice
        }
        guard let frontInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            throw CameraError.cannotCreateDevice
        }

        if !captureSession.canAddInput(backInput) || !captureSession.canAddInput(frontInput) {
            throw CameraError.cannotAddInputToSession
        }
        frontInputDevice = frontInput
        backInputDevice = backInput
        captureSession.addInput(backInput)
    }

    private func setupOutput() throws {
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            throw CameraError.cannotAddOutputVideo
        }
    }
}

extension CameraInteractor: CameraBusinessLogic {
    func setCameraPreviewFrame(view: UIView) {
        cameraView = view
    }

    func startCameraIfHavePermission(delegate: UIViewController, displayBelow layer: CALayer) {
        if isPermissionGranted {
            setUpAndStartCamera(delegate: delegate, displayBelow: layer)
        } else {
            presenter?.askForPermisson()
        }
    }

    func startCameraAndAskForPermission(delegate: UIViewController, displayBelow layer: CALayer) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                DispatchQueue.main.async { [weak self] in
                    self?.setUpAndStartCamera(delegate: delegate, displayBelow: layer)
                }
            } else {
                self.presenter?.askToOpenSettings()
            }
        }
    }

    func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }

    func revertCamera() {
        guard let backCamera = backInputDevice, let frontCamera = frontInputDevice else { return }
        if cameraDevice == .back {
            captureSession.removeInput(backCamera)
            captureSession.addInput(frontCamera)
            cameraDevice = .front
        } else {
            captureSession.removeInput(frontCamera)
            captureSession.addInput(backCamera)
            cameraDevice = .back
        }
    }

    func capturePhoto(with delegate: AVCapturePhotoCaptureDelegate) {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = flashMode
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
            photoOutput.capturePhoto(with: photoSettings, delegate: delegate)
        }
    }

    func switchFlashMode() {
        flashMode.toogle()
        presenter?.setFlashIconTo(flashMode.image)
    }
}
