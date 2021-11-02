//
//  AuthorizationModels.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 20.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

enum Authorization {
 
    // MARK: Use cases
    enum fetchUser {
        struct Request {
        }
        
        struct Response {
            var user: KeyChainModel?
        }
        
        struct ViewModel {
            var number: String
            var password: String
            var maskNumber: String
            var maskNumberModel: MaskNumberModel
        }
    }
    
    enum getMaskNumber {
        struct Request {
        }
        
        struct Response {
            var maskNumber: MaskNumberModel?
            var error: Errors?
        }
        
        struct ViewModel {
            var maskNumberModel: MaskNumberModel
            var error: String
        }
    }
    
    
    enum fetchModels {
        struct Request {
            var models: [MyDetailScreenModel]?
        }
        
        struct Response {
            var models: [MyDetailScreenModel]?
        }
        
        struct ViewModel {
            var models: [MyDetailScreenModel]
        }
    }
    
    enum saveUser {
        struct Request {
            var number: String
            var password: String
            var maskNumber: MaskNumberModel
            }
        
        struct Response {
        
        }
        
        struct ViewModel {

        }
    }
    
    enum checkUser {
        struct Request {
            var number: String
            var password: String
            var maskNumber: MaskNumberModel
            }
        
        struct Response {
            var error: Errors?
        }
        
        struct ViewModel {
            var error: String
        }
    }
    
}
