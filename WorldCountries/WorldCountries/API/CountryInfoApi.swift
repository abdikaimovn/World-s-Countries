//
//  CountryApi.swift
//  WorldCountries
//
//  Created by Нурдаулет on 08.06.2023.
//

import Foundation
import UIKit

struct CountryInfoApi{
    static let shared = CountryInfoApi()
    
    func replaceWhitespaces(str:String)->String{
        var newStr = ""
        for i in str{
            if i != " "{
                newStr += String(i)
            }else{
                newStr += "%20"
            }
        }
        return newStr
    }
    
    func fetchCountryInfo(nameOftheCountry name: String, completion: @escaping ([CountryInfo]?) -> Void) {

        let urlString = "https://restcountries.com/v3.1/name/\(replaceWhitespaces(str: name))"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let safeData = data else {
                print("data was nil")
                completion(nil)
                return
            }
            do {
                let countryInfo = try JSONDecoder().decode([CountryInfo].self, from: safeData)
                completion(countryInfo)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
    
}

struct CountryInfo: Codable{
    let flags: FlagOfTheCountry
    let region:String
    let capital:[String]
    let latlng:[Double]
    let population:Double
    let currencies: [String:Currency]
    let area:Double
    let timezones:[String]
}

struct Currency:Codable{
    let name:String
}
