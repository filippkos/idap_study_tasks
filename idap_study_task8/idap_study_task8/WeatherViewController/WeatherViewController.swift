import UIKit

class WeatherViewController: UIViewController, RootViewGettable, UISearchBarDelegate, UITableViewDataSource {
    
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
    
    var weatherArray: WeatherArray {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(weatherArray: WeatherArray) {
        self.weatherArray = weatherArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: WeatherTableViewCell.self)
        cell.fill(string: self.weatherArray[indexPath.row])
        return cell
    }
    
}
