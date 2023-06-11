//
//  ViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 06.06.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var countryList:[CountryModel] = []
    var getCountryList: [Country] = []
    var urlsOfImages:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //MARK: fetching data from API
        tableView.register(ListOfCountriesTableViewCell.self, forCellReuseIdentifier: "ListOfCountriesTableViewCell")
        CountryApi.shared.fetchCountryList { countryList in
            if let countryListFromAPI = countryList {
                for i in countryListFromAPI{
                    self.urlsOfImages.append(i.flags.png)
                    self.countryList.append(CountryModel(countryImage: UIImage(named:"Kazakhstan")!, countryName: i.name.common, capitalName: i.capital?.first ?? "Doesnt exist"))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.handleUrlsOfImages()
                }
            } else {
                print("Failed to fetch country list.")
            }
        }
        print(urlsOfImages)
    }
    func handleUrlsOfImages(){
        print(urlsOfImages)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: )
        let newViewController = CountryInfoViewController()
        navigationController?.navigationItem.backButtonTitle = "<"
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfCountriesTableViewCell") as! ListOfCountriesTableViewCell
        let imageURL = urlsOfImages[indexPath.row]
        CountryApi.imagesShared.fetchImage(from: imageURL) { image in
            DispatchQueue.main.async {
                cell.flagImageView.image = image
            }
        }
        cell.configure(countryInfo: countryList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
}
