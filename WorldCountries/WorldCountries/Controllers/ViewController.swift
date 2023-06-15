//
//  ViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 06.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var countryList:[CountryModel] = []
    private var label: UILabel = {
        let label = UILabel()
        label.text = "World's Countries"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    private lazy var tableView:UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(ListOfCountriesTableViewCell.self, forCellReuseIdentifier: "ListOfCountriesTableViewCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let countryManager = CountryManager()
        countryManager.delegate = self
        countryManager.retrieveDataFromAPI()
        setupViews()
    }

    private func setupViews(){
        self.view.addSubview(label)
        self.view.backgroundColor = .white
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(0)
            make.top.equalTo(label.snp.bottom).offset(10)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = CountryInfoViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        CountryInfoViewController.countryName = countryList[indexPath.row].countryName
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

extension ViewController: CountryListDelegate{
    func didLoadCountryList(_ countryList: [Country]) {
        for country in countryList {
            self.countryList.append(CountryModel(countryImageURL:country.flags.png,
                                                 countryName: country.name.common,
                                                 capitalName: country.capital?.first ??
                                                 "Doesn't exist"))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func didLoadFailure() {
        print("Fail...")
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfCountriesTableViewCell") as! ListOfCountriesTableViewCell
        cell.configure(countryInfo: countryList[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
}

