//
//  KeyChainModel.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 28.10.2021.
//

import Foundation


struct KeyChainModel: Codable {
    var number: String?
    var password: String?
    var maskNumber: MaskNumberModel?
}
