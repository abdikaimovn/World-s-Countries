//
//  MainView.swift
//  WorldCountries
//
//  Created by Нурдаулет on 02.10.2023.
//

import UIKit

// Protocol for communication between MainView and MainViewController
protocol MainViewControllerDelegate: AnyObject {
    func didTapCell(_ cellIndex: Int)
}

// Protocol for communication between MainView and MainViewController
protocol MainViewDelegate: AnyObject {
    func reloadTableView(countryList: [CountryModel])
}

// Main view class
class MainView: UIView {
    // Array to store country data
    private var countryList = [CountryModel]()
    
    // Weak reference to the delegate for cell tap events
    weak var mainVCDelegate: MainViewControllerDelegate?
    
    // Header label
    private var header: UILabel = {
        let label = UILabel()
        label.text = "World's Countries"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    // Table view to display the list of countries
    private lazy var countryListTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.register(ListOfCountriesTableViewCell.self, forCellReuseIdentifier: "ListOfCountriesTableViewCell")
        return table
    }()
    
    // Initialize MainView with a reference to MainViewController
    init(mainViewController: MainViewController) {
        self.mainVCDelegate = mainViewController
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .white
        countryListTableView.separatorStyle = .none
        
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

// Conform to UITableViewDelegate and UITableViewDataSource
extension MainView: UITableViewDelegate, UITableViewDataSource {
    // Handle cell selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainVCDelegate?.didTapCell(indexPath.row)
    }

    // Return the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }
    
    // Configure and return a table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfCountriesTableViewCell") as! ListOfCountriesTableViewCell
        cell.configure(countryInfo: countryList[indexPath.row])
        return cell
    }
}

// Conform to MainViewDelegate for table view data reloading
extension MainView : MainViewDelegate {
    // Reload the table view with new country data
    func reloadTableView(countryList: [CountryModel]) {
        self.countryList = countryList
        
        DispatchQueue.main.async {
            self.countryListTableView.reloadData()
        }
    }
}
