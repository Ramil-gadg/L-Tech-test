//
//  NetworkManager.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 18.10.2021.
//

import Foundation


class NetworkManager {
    
    static var shared = NetworkManager()
    let url = "http://dev-exam.l-tech.ru"
    private init () {}
    
    func getMaskNumber (completion: @escaping (Result<MaskNumberModel?, Errors>) -> Void) {
        guard let url = URL(string: "\(url)/api/v1/phone_masks") else {
            return completion(.failure(Errors.invalidURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(Errors.serverProblem))
                return
            }
            guard let data = data else {
                completion(.failure(Errors.serverProblem))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(MaskNumberModel.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(Errors.decodeDataProblem))
            }
        }.resume()
    }
    
    
    
    func auth(userModel: UserModel, completion: @escaping (Result <Bool, Errors>) -> Void) {
        
        do {
            guard let url = URL(string: "\(url)/api/v1/auth") else {
                completion(.failure(Errors.invalidURL))
                return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(userModel)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    if let httpResponse = response as? HTTPURLResponse, (401...403).contains(httpResponse.statusCode) {
                        completion(.success(false))
                        return
                    } else {
                        completion(.failure(Errors.serverProblem))
                        return
                    }
                }
                completion(.success(true))
            }.resume()
            
        } catch {
            completion(.failure(Errors.encodeDataProblem))
        }
    }
    
    
    
    func getDetailInfo(completion: @escaping (Result<[DetailScreenModel]?, Errors>) -> Void) {
        guard let url = URL(string: "\(url)/api/v1/posts") else {
            completion(.failure(Errors.invalidURL))
            return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(Errors.serverProblem))
                return
            }
            guard let data = data else {
                completion(.failure(Errors.serverProblem))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode([DetailScreenModel].self, from: data)
                completion(.success(jsonData))
            } catch{
                completion(.failure(Errors.decodeDataProblem))
            }
        }.resume()
    }
}
