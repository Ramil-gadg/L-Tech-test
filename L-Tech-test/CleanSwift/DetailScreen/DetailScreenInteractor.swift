//
//  DetailScreenInteractor.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 20.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol DetailScreenBusinessLogic {
    func provideDetailScreen()
}

protocol DetailScreenDataStore {
    var model: MyDetailScreenModel? {get set}
}

class DetailScreenInteractor: DetailScreenBusinessLogic, DetailScreenDataStore {
    
    var presenter: DetailScreenPresentationLogic?
    var worker: DetailScreenWorker?
    var model: MyDetailScreenModel?
    
    func provideDetailScreen() {

        worker = DetailScreenWorker()

        let imageData = worker?.getImage(from: model?.image)
      //  let image = ImageManager.shared.fetchImageData(from: model?.image)
        
        
        let response = DetailScreen.ShowDetails.Response(
            modelTitle: model?.title,
            modelText: model?.text,
            imageData: imageData
        )
        print(response.modelTitle ?? "nononono")
        presenter?.presentScreenDetail(response: response)
    }
}
