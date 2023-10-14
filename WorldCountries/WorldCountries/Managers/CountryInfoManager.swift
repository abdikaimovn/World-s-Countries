//
//  CountryInfoManager.swift
//  WorldCountries
//
//  Created by Нурдаулет on 11.06.2023.
//

import Foundation

// Protocol to define delegate methods for handling country information data
protocol CountryInfoDelegate {
    // Called when country information data is successfully loaded
    func didLoadCountryInfo(_ countryInfo: [CountryInfo])
    
    // Called when there is a failure in loading country information data
    func didLoadFailure()
}

// Class responsible for managing country information data retrieval
class CountryInfoManager {
    // Delegate reference to notify about data loading status
    var delegate: CountryInfoDelegate?
    
    // Function to retrieve country information data from an API
    func retrieveDataFromAPI(countryName: String) {
        // Use the shared CountryInfoApi instance to fetch country information data
        CountryInfoApi.shared.fetchCountryInfo(nameOftheCountry: countryName) { countryInfo in
            if let safeCountryInfo = countryInfo {
                // Notify the delegate about successful data loading
                self.delegate?.didLoadCountryInfo(safeCountryInfo)
            } else {
                // Notify the delegate about data loading failure
                self.delegate?.didLoadFailure()
            }
        }
    }
}
