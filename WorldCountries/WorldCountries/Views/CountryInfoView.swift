//
//  CountryInfoView.swift
//  WorldCountries
//
//  Created by Нурдаулет on 03.10.2023.
//

import UIKit

protocol CountryInfoVCDelegate {
    func didReceiveFlagImage(image: UIImage)
    func reloadTableViewWithNewData(countryInfo: CountryInfoModel)
}

class CountryInfoView: UIView {
    private var countryInfo: CountryInfoModel?
    private let infoTypes = InfoType.allCases
    
    private var flagImage: UIImageView = {
        let flag = UIImageView()
        flag.layer.cornerRadius = 5
        flag.layer.masksToBounds = false
        flag.clipsToBounds = true
        flag.image = UIImage(systemName: "placeholder")
        return flag
    }()
    
    private lazy var tableView:UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: "CountryInfoTableViewCell")
        table.separatorStyle = .none
        table.dataSource = self
        table.isScrollEnabled = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addSubview(flagImage)
        flagImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(166.6)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(flagImage.snp.bottom).offset(26.4)
            make.bottom.equalToSuperview().offset(300)
            make.centerX.equalToSuperview()
            make.width.equalTo(flagImage.snp.width)
        }
    }

}

extension CountryInfoView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfoTableViewCell", for: indexPath) as! CountryInfoTableViewCell
        guard let model = countryInfo else {return cell}
        
        switch infoTypes[indexPath.row]{
        case .area:
            cell.configure("Area:", String(model.area))
        case .region:
            cell.configure("Region:", model.region)
        case .capital:
            cell.configure("Capital:", model.capital)
        case .capitalCoordinates:
            cell.configure("Capital Coordinates",
                           "\(model.capitalCoordinates[0]), \(model.capitalCoordinates[1])")
        case .population:
            cell.configure("Population:", String(model.population))
        case .currency:
            cell.configure("Currency:", model.currency)
        case .timeZones:
            cell.configure("Timezones:", model.timeZones)
        }
        return cell
    }
}

extension CountryInfoView: CountryInfoVCDelegate {
    func didReceiveFlagImage(image: UIImage) {
        self.flagImage.image = image
    }
    
    func reloadTableViewWithNewData(countryInfo: CountryInfoModel) {
        self.countryInfo = countryInfo
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
