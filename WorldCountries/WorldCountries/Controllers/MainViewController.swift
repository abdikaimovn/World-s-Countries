// Import necessary modules
import UIKit
import SnapKit

// Define the main view controller class
class MainViewController: UIViewController {
    // Declare a weak reference to the MainViewDelegate protocol
    weak var mainViewDelegate: MainViewDelegate?
    
    // Create an array to store country data
    private var countryList = [CountryModel]()
    
    // Called when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an instance of the MainView
        let mainView = MainView(mainViewController: self)
        
        // Set the mainViewDelegate to the created MainView
        mainViewDelegate = mainView
        
        // Set up the view and load country data
        setupView(with: mainView)
    }

    // Set up the view and load country data
    private func setupView(with view: UIView){
        // Set the background color of the view
        self.view.backgroundColor = .black
        
        // Create an instance of CountryManager to fetch data
        let countryManager = CountryManager()
        
        // Set the delegate of CountryManager to this view controller
        countryManager.delegate = self
        
        // Fetch country data from an API
        countryManager.retrieveDataFromAPI()
    
        // Add the main view as a subview
        self.view.addSubview(view)
        
        // Define constraints for the main view
        view.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(0)
        }
    }
}

// Conform to the MainViewControllerDelegate protocol
extension MainViewController: MainViewControllerDelegate {
    // Handle tapping on a cell
    func didTapCell(_ cellIndex: Int) {
        // Create a CountryInfoViewController with the selected country's name
        let countryInfoVC = CountryInfoViewController(countryName: countryList[cellIndex].countryName)
        
        // Push the CountryInfoViewController onto the navigation stack
        self.navigationController?.pushViewController(countryInfoVC, animated: true)
    }
}

// Conform to the CountryListDelegate protocol
extension MainViewController: CountryListDelegate {
    // Handle successful loading of country list
    func didLoadCountryList(_ countryList: [Country]) {
        // Iterate through the received country data and create CountryModel objects
        for country in countryList {
            self.countryList.append(CountryModel(countryImageURL: country.flags.png,
                                                 countryName: country.name.common,
                                                 capitalName: country.capital?.first ?? "Doesn't exist"))
        }
        
        // Call the reloadTableView method of the mainViewDelegate
        mainViewDelegate?.reloadTableView(countryList: self.countryList)
    }
    
    // Handle failure in loading country list
    func didLoadFailure() {
        print("Fail...")
    }
}
