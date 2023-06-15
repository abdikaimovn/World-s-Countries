//
//  DataFromAPIModel.swift
//  WorldCountries
//
//  Created by Нурдаулет on 08.06.2023.
//

import Foundation

struct DataFromAPIModel:Decodable{
    let countryName: Name
    let capitalName
}
struct Name:Decodable{
    let common:String
}
