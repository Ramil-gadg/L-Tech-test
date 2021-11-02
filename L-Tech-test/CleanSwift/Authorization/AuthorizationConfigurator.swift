//
//  AuthorizationConfigurator.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 28.10.2021.
//

import Foundation


class AuthorizationConfigurator {
    static let shared = AuthorizationConfigurator()
    private init (){}
    func configure(with viewController: AuthorizationViewController) {
        let interactor = AuthorizationInteractor()
        let presenter = AuthorizationPresenter()
        let router = AuthorizationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
