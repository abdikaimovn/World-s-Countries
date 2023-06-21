//
//  CountryManager.swift
//  WorldCountries
//
//  Created by Нурдаулет on 11.06.2023.
//

import Foundation

protocol CountryInfoDelegate{
    func didLoadCountryInfo(_ countryInfo: [CountryInfo])
    func didLoadFailure()
}

class CountryInfoManager{
    var delegate:CountryInfoDelegate?
    
    func retrieveDataFromAPI(countryName: String){
        CountryInfoApi.shared.fetchCountryInfo(nameOftheCountry: countryName) { countryInfo in
            if let safeCountryInfo = countryInfo{
                self.delegate?.didLoadCountryInfo(safeCountryInfo)
            }else{
                self.delegate?.didLoadFailure()
            }
        }
    }
}
