//
//  ErrorsTypes.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 26.10.2021.
//

import Foundation


enum Errors: Error {
    case invalidURL
    case authProblem
    case serverProblem
    case encodeDataProblem
    case decodeDataProblem
    case unknownError
    
}

extension Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Ссылка недействительна или временно недоступна", comment: "")
        case .authProblem:
            return NSLocalizedString(" Ошибка авторизации пользователя", comment: "")
        case .serverProblem:
            return NSLocalizedString("Ошибка при взаимодействии с сервером", comment: "")
        case .encodeDataProblem:
            return NSLocalizedString("Ошибка кодирования пользователя", comment: "")
        case .decodeDataProblem:
            return NSLocalizedString("Ошибка декодирования ответа от сервера", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}
