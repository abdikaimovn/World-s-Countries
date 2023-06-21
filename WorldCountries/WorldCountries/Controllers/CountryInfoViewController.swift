//
//  CountryInfoViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 14.06.2023.
//

import UIKit
import SnapKit

enum InfoType{
    case region,
         capital,
         capitalCoordinates,
         population,
         area,
         currency,
         timeZones
}

class CountryInfoViewController: UIViewController{
    var countryName:String?
    var countryFlagImageUrl = ""
    let countryInfoManager = CountryInfoManager()
    var countryInfoModel: CountryInfoModel?
    
    let infoTypes:[InfoType] = [
        .region,
        .capital,
        .capitalCoordinates,
        .population,
        .area,
        .currency,
        .timeZones
    ]
    
    private var canvas: UIView = {
        let canvas = UIView()
        canvas.backgroundColor = .white
        return canvas
    }()
    
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
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryInfoManager.delegate = self
        countryInfoManager.retrieveDataFromAPI(countryName: countryName!)
        setupViews()
    }
    
    init(countryName: String) {
        self.countryName = countryName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        navigationItem.title = countryName
        navigationItem.titleView?.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "❮",
            style: .done,
            target: self,
            action: nil
        )
    
        self.view.addSubview(canvas)
        canvas.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(0)
        }
        
        self.canvas.addSubview(flagImage)
        flagImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(166.6)
        }
        
        self.canvas.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(flagImage.snp.bottom).offset(26.4)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(canvas.snp.bottom).offset(311)
            make.width.equalTo(flagImage.snp.width)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            tableView.isScrollEnabled = false
        }
    }
}

extension CountryInfoViewController: CountryInfoDelegate{
    func didLoadCountryInfo(_ countryInfo: [CountryInfo]) {
        if let countryFlagUrl = countryInfo.first?.flags.png{
            CountryInfoApi.shared.fetchImage(from: countryFlagUrl) { image in
                DispatchQueue.main.async {
                    self.flagImage.image = image
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
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didLoadFailure() {
        print("Something went wrong")
    }
}

extension CountryInfoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
    }
}

extension CountryInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfoTableViewCell", for: indexPath) as! CountryInfoTableViewCell
        guard let model = countryInfoModel else {return cell}
        
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
