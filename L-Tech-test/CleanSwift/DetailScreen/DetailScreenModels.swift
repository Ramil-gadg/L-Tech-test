//
//  DetailScreenModels.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 20.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

enum DetailScreen {
 
    // MARK: Use cases
    enum ShowDetails {
        struct Request {
        }
        
        struct Response {
            let modelTitle: String?
            let modelText: String?
            let imageData: Data?
        }
        
        struct ViewModel {
            let modelTitle: String
            let modelText: String
            let imageData: Data
        }
    }
}
