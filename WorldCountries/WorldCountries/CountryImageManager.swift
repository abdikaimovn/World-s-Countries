//
//  CountryImageManager.swift
//  WorldCountries
//
//  Created by Нурдаулет on 12.06.2023.
//

import Foundation
import UIKit
protocol CountryImageDelegate{
    func didLoadImage(images:[UIImage])
}

class CountryImageManager{
    var delegate: CountryImageDelegate?
    var imagesFromAPI = [UIImage]()
    func retrieveCountryImage(imageURLS: [String]){
        for i in imageURLS{
            CountryApi.shared.fetchImage(from: i) { image in
                DispatchQueue.main.async {
                    if let safeImage = image{
                        self.imagesFromAPI.append(safeImage)
                    }else{
                        self.imagesFromAPI.append(UIImage(named: "Kazakhstan")!)
                    }
                }
            }
        }
        self.delegate?.didLoadImage(images: self.imagesFromAPI)
    }
}

