//
//  DetailScreenWorker.swift
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


class DetailScreenWorker {
    func getImage(from imageString: String?) -> Data? {
        ImageManager.shared.fetchImageData(from: imageString)
    }
}
