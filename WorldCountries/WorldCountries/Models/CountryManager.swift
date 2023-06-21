//
//  CountryManager.swift
//  WorldCountries
//
//  Created by Нурдаулет on 11.06.2023.
//

import Foundation

protocol CountryListDelegate{
    func didLoadCountryList(_ countryList: [Country])
    func didLoadFailure()
}
class CountryManager{
    var delegate:CountryListDelegate?
    
    func retrieveDataFromAPI(){
        CountryApi.shared.fetchCountryList { countryList in
            if let countryListFromAPI = countryList {
                self.delegate?.didLoadCountryList(countryListFromAPI)
            }else{
                self.delegate?.didLoadFailure()
            }
        }
    }
}
