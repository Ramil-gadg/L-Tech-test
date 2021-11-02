//
//  ImageManager.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 28.10.2021.
//

import UIKit

class ImageManager {
    
    
    static var shared = ImageManager()
    private init() {}
    
    func fetchImageData(from string: String?) -> Data? {
    
        guard let string = string, let url = URL(string: string), let imageData = try? Data(contentsOf: url)  else {return nil}
        return imageData
    }
}



//if let cachedImage = imageCache.object(forKey: string! as NSString) {
//return cachedImage
//}

//imageCache.setObject(image, forKey: string as NSString)
