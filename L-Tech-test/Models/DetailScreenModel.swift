//
//  DetailScreenModel.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 19.10.2021.
//

import Foundation


struct DetailScreenModel: Codable {
    let id: String?
    var title, text: String?
    let image: String?
    let sort: Int?
    let date: String?
}

struct MyDetailScreenModel {
    var id: String?
    var title, text: String?
    var image: String?
    var sort: Int?
    var date: Date?
    
    init(detailScreenModel: DetailScreenModel) {
        self.id = detailScreenModel.id
        self.title = detailScreenModel.title
        self.text = detailScreenModel.text
        self.image = "http://dev-exam.l-tech.ru\(detailScreenModel.image!)"
        self.sort = detailScreenModel.sort
        let date = getDateFromString(inputDate: detailScreenModel.date!)
        self.date = date
    }
 
}
