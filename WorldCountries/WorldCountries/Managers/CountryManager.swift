//
//  CountryManager.swift
//  WorldCountries
//
//  Created by Нурдаулет on 11.06.2023.
//

import Foundation

// Protocol to define delegate methods for handling country data
protocol CountryListDelegate {
    // Called when country data is successfully loaded
    func didLoadCountryList(_ countryList: [Country])
    
    // Called when there is a failure in loading country data
    func didLoadFailure()
}

// Class responsible for managing country data retrieval
class CountryManager {
    // Delegate reference to notify about data loading status
    var delegate: CountryListDelegate?
    
    // Function to retrieve country data from an API
    func retrieveDataFromAPI() {
        // Use the shared CountryApi instance to fetch country data
        CountryApi.shared.fetchCountryList { countryList in
            if let countryListFromAPI = countryList {
                // Notify the delegate about successful data loading
                self.delegate?.didLoadCountryList(countryListFromAPI)
            } else {
                // Notify the delegate about data loading failure
                self.delegate?.didLoadFailure()
            }
        }
    }
}
