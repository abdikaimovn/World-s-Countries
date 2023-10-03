//
//  CountryInfoApi.swift
//  WorldCountries
//
//  Created by Нурдаулет on 08.06.2023.
//

import Foundation
import UIKit

// Singleton structure to handle country information-related API calls
struct CountryInfoApi {
    // Shared instance of CountryInfoApi for Singleton pattern
    static let shared = CountryInfoApi()
    
    // Replace white spaces with "%20" in a string for URL compatibility
    func replaceWhiteSpaces(str: String) -> String {
        var newStr = ""
        for i in str {
            if i != " " {
                newStr += String(i)
            } else {
                newStr += "%20"
            }
        }
        return newStr
    }
    
    // Fetch country information based on the country name
    func fetchCountryInfo(nameOftheCountry name: String, completion: @escaping ([CountryInfo]?) -> Void) {
        // Build the URL using the provided country name
        let urlString = "https://restcountries.com/v3.1/name/\(replaceWhiteSpaces(str: name))"
        let url = URL(string: urlString)!
        
        // Create a data task to make the API request
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors or nil data
            guard let safeData = data else {
                print("Data was nil")
                completion(nil)
                return
            }
            
            do {
                // Decode the JSON response into an array of CountryInfo objects
                let countryInfo = try JSONDecoder().decode([CountryInfo].self, from: safeData)
                completion(countryInfo)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume() // Start the data task
    }
    
    // Fetch an image from a given URL
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        
        // Create a data task to download the image
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for network errors
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Check if data is valid and convert it to an image
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            
            completion(image)
        }.resume() // Start the data task
    }
}

// Struct to represent country information with its properties
struct CountryInfo: Codable {
    let flags: CountryFlag
    let region: String
    let capital: [String]
    let latlng: [Double]
    let population: Double
    let currencies: [String: Currency]
    let area: Double
    let timezones: [String]
}

// Struct to represent currency information
struct Currency: Codable {
    let name: String
}
