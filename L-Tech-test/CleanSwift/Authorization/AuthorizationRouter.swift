//
//  AuthorizationRouter.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 20.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol AuthorizationRoutingLogic {
    func routeToMainScreen()
}

protocol AuthorizationDataPassing {
    var dataStore: AuthorizationDataStore? { get }
}

class AuthorizationRouter: NSObject, AuthorizationRoutingLogic, AuthorizationDataPassing {
    
    weak var viewController: AuthorizationViewController?
    var dataStore: AuthorizationDataStore?
    
    // MARK: Routing
    func routeToMainScreen() {

            let startVC = viewController
            let startDS = dataStore
            let mainScreenVC = MainScreenViewController()
            var mainScreenDS = mainScreenVC.router?.dataStore
            passDataToMainScreen(source: startDS!, destination: &mainScreenDS!)
            navigateToMainScreen(source: startVC!, destination: mainScreenVC)
      
    }
    
    // MARK: Navigation
    
    func navigateToMainScreen(source: AuthorizationViewController, destination: MainScreenViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    
    // MARK: Passing data

    func passDataToMainScreen(source: AuthorizationDataStore, destination: inout MainScreenDataStore) {
        destination.models = source.models
    }
}
