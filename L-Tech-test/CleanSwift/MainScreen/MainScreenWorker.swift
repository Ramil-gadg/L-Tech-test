//
//  MainScreenWorker.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 20.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

class MainScreenWorker {
    func fetchModels(response: @escaping ([MyDetailScreenModel]?) -> Void) {

        var myModels: [MyDetailScreenModel]? = []
        NetworkManager.shared.getDetailInfo { (result) in
            switch result {
            case .success(let models):
                guard models != nil else { return response([])}
                for model in models! {
                    let myModel = MyDetailScreenModel(detailScreenModel: model)
                    myModels?.append(myModel)
                }
                response(myModels)
            case .failure(let error):
                print(error)
                response([])
            }
        }
    }
}
