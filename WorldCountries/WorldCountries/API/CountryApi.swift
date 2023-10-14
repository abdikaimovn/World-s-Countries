//
//  CountryApi.swift
//  WorldCountries
//
//  Created by Нурдаулет on 08.06.2023.
//

import Foundation
import UIKit

// Singleton structure to handle country-related API calls
struct CountryApi {
    // Shared instance of CountryApi for Singleton pattern
    static let shared = CountryApi()
    private var defaultQueue = DispatchQueue.global(qos: .default)
    
    // Fetch a list of countries from the API
    func fetchCountryList(completion: @escaping ([Country]?) -> Void) {
        // Define the URL for the country data API
        let url = URL(string: "https://restcountries.com/v3.1/all")!
        
        // Create a data task to make the API request
        defaultQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors or nil data
                guard let safeData = data else {
                    print("Data was nil")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                do {
                    // Decode the JSON response into an array of Country objects
                    let countryList = try JSONDecoder().decode([Country].self, from: safeData)
                    DispatchQueue.main.async {
                        completion(countryList)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
    
    // Fetch an image from a given URL
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Create a URL from the provided string
        let url = URL(string: urlString)!
        
        // Create a data task to download the image
        defaultQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for network errors
                if let error = error {
                    print("Error fetching image: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                // Check if data is valid and convert it to an image
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }// Start the data task
    }
}

// Struct to represent a country with its properties
struct Country: Codable {
    let flags: CountryFlag
    let name: CountryName
    let capital: [String]?
}

// Struct to represent country flags
struct CountryFlag: Codable {
    let png: String
}

// Struct to represent country names
struct CountryName: Codable {
    let common: String
}
