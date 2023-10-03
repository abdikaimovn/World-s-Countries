//
//  CountryInfoViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 14.06.2023.
//

import UIKit
import SnapKit

enum InfoType: CaseIterable{
    case region,
         capital,
         capitalCoordinates,
         population,
         area,
         currency,
         timeZones
}

class CountryInfoViewController: UIViewController{
    private var delegate: CountryInfoVCDelegate?
    private var countryInfoView: UIView?
    private var countryName: String?
    private let countryInfoManager = CountryInfoManager()
    private var countryInfoModel: CountryInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryInfoManager.delegate = self
        countryInfoManager.retrieveDataFromAPI(countryName: countryName!)

        let countryInfoView = CountryInfoView()
        view = countryInfoView
        delegate = countryInfoView
    }

    
    init(countryName: String) {
        self.countryName = countryName
        super.init(nibName: nil, bundle: nil)
        self.title = countryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CountryInfoViewController: CountryInfoDelegate{
    func didLoadCountryInfo(_ countryInfo: [CountryInfo]) {
        if let countryFlagUrl = countryInfo.first?.flags.png{
            CountryInfoApi.shared.fetchImage(from: countryFlagUrl) { image in
                DispatchQueue.main.async {
                    self.delegate?.didReceiveFlagImage(image: image!)
                }
            }
        }
        
        // Initiating the country model
        let coordinates:[Double] = [countryInfo.first?.latlng[0] ?? 0.0,  countryInfo.first?.latlng[1] ?? 0.0]
        countryInfoModel = CountryInfoModel(
            region: countryInfo.first?.region ?? "Fail...",
            capital: countryInfo.first?.capital.first ?? "Fail...",
            capitalCoordinates: coordinates,
            population: countryInfo.first?.population ?? 0,
            area: countryInfo.first?.area ?? 0.0,
            currency: countryInfo.first?.currencies.first?.value.name ?? "Fail...",
            timeZones: countryInfo.first?.timezones.first ?? "Fail..."
        )
        
        delegate?.reloadTableViewWithNewData(countryInfo: countryInfoModel!)
    }
    
    func didLoadFailure() {
        print("Something went wrong")
    }
}
