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
    func retrieveDataFromAPI(){
        CountryInfoApi.shared.fetchCountryInfo { countryInfo in
            if let safeCountryInfo = countryInfo{
                self.delegate?.didLoadCountryInfo(safeCountryInfo)
            }else{
                self.delegate?.didLoadFailure()
            }
        }
    }
}
