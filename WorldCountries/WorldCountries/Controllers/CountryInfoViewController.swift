//
//  CountryInfoViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 14.06.2023.
//

import UIKit
import SnapKit
class CountryInfoViewController: UIViewController{
    static var countryName:String?
    var countryFlagImageUrl = ""
    var countryInfoToSetValues = [String]()
    let countryLabels = [
        "Region:",
        "Capital:",
        "Capital Coordinates:",
        "Population:",
        "Area:",
        "Currency:",
        "Timezones:"
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
        flag.image = UIImage(named: "Kazakhstan")!
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
        let countryInfoManager = CountryInfoManager()
        countryInfoManager.delegate = self
        countryInfoManager.retrieveDataFromAPI()
        setupViews()
    }
    
    @objc func backButtonTapped() {
        // Dismiss the current view controller
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews(){
        navigationItem.title = CountryInfoViewController.countryName
        navigationItem.titleView?.tintColor = .black
        let backButton = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(backButtonTapped))
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        separatorView.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: 1)
        
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.addSubview(separatorView)
        
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
        countryInfoToSetValues.append(countryInfo.first?.region ?? "nil")
        countryInfoToSetValues.append(countryInfo.first?.capital.first ?? "nil")
        if let firstCoordinate = countryInfo.first?.latlng.first,
           let secondCoordinate = countryInfo.first?.latlng[1]{
            countryInfoToSetValues.append("\(firstCoordinate), \(secondCoordinate)")
        }else{
            countryInfoToSetValues.append("nil")
        }
        countryInfoToSetValues.append("\(countryInfo.first?.population ?? 0)")
        countryInfoToSetValues.append("\(countryInfo.first?.area ?? 0)")
        countryInfoToSetValues.append(countryInfo.first?.currencies.first?.value.name ?? "nil")
        countryInfoToSetValues.append(countryInfo.first?.timezones.first ?? "nil")
        print(countryInfoToSetValues)
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
        return countryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfoTableViewCell", for: indexPath) as! CountryInfoTableViewCell
        cell.configure(countryLabels[indexPath.row], countryInfoToSetValues[indexPath.row])
        return cell
    }
    
}
