//
//  ModuleFactory.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 25/06/2023.
//

import UIKit

enum ModuleFactory {
    static func createCameraNavigationController() -> UINavigationController {
        var viewer = CameraViewController()
        var interactor = CameraInteractor()
        var presenter = CameraPresenter()
        var router = CameraRouter()
        ModuleFactory.setUpModule(
            viewContorller: &viewer,
            interactor: &interactor,
            presenter: &presenter,
            router: &router
        )
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewer]
        return navigationController
    }

    static func setUpModule<V: Viewable, I: Interactable, P: Presentable, R: Routable>(
        viewContorller: inout V,
        interactor: inout I,
        presenter: inout P,
        router: inout R
    ) {
        viewContorller.interactor = interactor as? V.Interactable
        viewContorller.router = router as? V.Routable
        interactor.presenter = presenter as? I.Presentable
        presenter.viewController = viewContorller as? P.Viewable
        router.viewController = viewContorller as? R.Viewable
    }
}
