//
//  ViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 06.06.2023.
//

import UIKit
import SnapKit


class MainViewController: UIViewController {
    weak var mainViewDelegate: MainViewDelegate?
    var countryList = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = MainView(mainViewController: self)
        mainViewDelegate = mainView
        
        setupView(with: mainView)
    }

    private func setupView(with view: UIView){
        self.view.backgroundColor = .black
        let countryManager = CountryManager()
        countryManager.delegate = self
        countryManager.retrieveDataFromAPI()
    
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(0)
        }
    }
}

extension MainViewController: MainViewControllerDelegate {
    func didTapCell(_ cellIndex: Int) {
        let countryInfoVC = CountryInfoViewController(countryName: countryList[cellIndex].countryName)
        self.navigationController?.pushViewController(countryInfoVC, animated: true)
    }
}

extension MainViewController: CountryListDelegate{
    func didLoadCountryList(_ countryList: [Country]) {
        for country in countryList {
            self.countryList.append(CountryModel(countryImageURL:country.flags.png,
                                                 countryName: country.name.common,
                                                 capitalName: country.capital?.first ??
                                                 "Doesn't exist"))
        }
        
        mainViewDelegate?.reloadTableView(countryList: self.countryList)
    }
    
    func didLoadFailure() {
        print("Fail...")
    }
}


