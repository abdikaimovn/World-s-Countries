//
//  MainView.swift
//  WorldCountries
//
//  Created by Нурдаулет on 02.10.2023.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func didTapCell(_ cellIndex: Int)
}

protocol MainViewDelegate: AnyObject {
    func reloadTableView(countryList: [CountryModel])
}

class MainView: UIView {
    var countryList = [CountryModel]()
    weak var mainVCDelegate: MainViewControllerDelegate?
    
    private var header: UILabel = {
        let label = UILabel()
        label.text = "World's Countries"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var countryListTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.register(ListOfCountriesTableViewCell.self, forCellReuseIdentifier: "ListOfCountriesTableViewCell")
        return table
    }()
    
    init(mainViewController: MainViewController) {
        self.mainVCDelegate = mainViewController
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .white
        
        addSubview(header)
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(-30)
            make.centerX.equalToSuperview()
        }
        
        addSubview(countryListTableView)
        countryListTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(0)
            make.top.equalTo(header.snp.bottom).offset(10)
        }
    }

}


extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainVCDelegate?.didTapCell(indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfCountriesTableViewCell") as! ListOfCountriesTableViewCell
        cell.configure(countryInfo: countryList[indexPath.row])
        return cell
    }
}

extension MainView : MainViewDelegate {
    func reloadTableView(countryList: [CountryModel]) {
        self.countryList = countryList
        
        DispatchQueue.main.async {
            self.countryListTableView.reloadData()
        }
    }
}
