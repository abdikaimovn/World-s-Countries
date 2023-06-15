//
//  CountryApi.swift
//  WorldCountries
//
//  Created by Нурдаулет on 08.06.2023.
//

import Foundation
import UIKit

struct CountryApi{
    static let shared = CountryApi()
    func fetchCountryList(completion: @escaping ([Country]?) -> Void) {
        let urlString = "https://restcountries.com/v3.1/all"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let safeData = data else {
                print("data was nil")
                completion(nil)
                return
            }
            do {
                let countryList = try JSONDecoder().decode([Country].self, from: safeData)
                completion(countryList)
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


struct Country: Codable{
    let flags: FlagOfTheCountry
    let name: CountryName
    let capital: [String]?
}

struct FlagOfTheCountry:Codable{
    let png:String
}

struct CountryName:Codable{
    let common: String
}
/*
 [
   {
     "name": {
       "common": "Jordan",
       "official": "Hashemite Kingdom of Jordan",
       "nativeName": {
         "ara": {
           "official": "Ø§Ù„Ù…Ù…Ù„ÙƒØ© Ø§Ù„Ø£Ø±Ø¯Ù†ÙŠØ© Ø§Ù„Ù‡Ø§Ø´Ù…ÙŠØ©",
           "common": "Ø§Ù„Ø£Ø±Ø¯Ù†"
         }
       }
     },
     "tld": [
       ".jo",
       "Ø§Ù„Ø§Ø±Ø¯Ù†."
     ],
     "cca2": "JO",
     "ccn3": "400",
     "cca3": "JOR",
     "cioc": "JOR",
     "independent": true,
     "status": "officially-assigned",
     "unMember": true,
     "currencies": {
       "JOD": {
         "name": "Jordanian dinar",
         "symbol": "Ø¯.Ø§"
       }
     },
     "idd": {
       "root": "+9",
       "suffixes": [
         "62"
       ]
     },
     "capital": [
       "Amman"
     ],
     "altSpellings": [
       "JO",
       "Hashemite Kingdom of Jordan",
       "al-Mamlakah al-UrdunÄ«yah al-HÄshimÄ«yah"
     ],
 */
