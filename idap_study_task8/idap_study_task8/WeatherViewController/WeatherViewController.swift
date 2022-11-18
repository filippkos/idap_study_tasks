import UIKit

class WeatherViewController: UIViewController, RootViewGettable, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = WeatherView
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.searchBar?.delegate = self
        self.rootView?.tableView?.register(cellClass: WeatherTableViewCell.self)
    }
    
    // MARK: -
    // MARK: Variables
    
    var offerModel: OfferModel? {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    var timer = Timer()
    var dataIsReady: Bool = false
    
    // MARK: -
    // MARK: Delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let city = searchText
        
        timer.invalidate()
        
        if city != "" {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                NetworkManager.shared.getWeather(city: city, completion: { (model) in
                    DispatchQueue.main.async {
                        if model != nil {
                            self.dataIsReady = true
                            self.offerModel = model
                        } else {
                            let alert = UIAlertController(title: "error", message: "something wrong", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .cancel)
                            alert.addAction(action)
                            self.present(alert, animated: true)
                        }
                    }
                })
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataIsReady {
            if let numOfRows = self.offerModel?.list?.count {
                return numOfRows
            }
        } else {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: WeatherTableViewCell.self)
        if self.offerModel != nil {
            cell.daytimeTemperatureLabel?.text = self.offerModel?.list?[indexPath.row].main?.temp?.description
        }
        return cell
    }
    
}
