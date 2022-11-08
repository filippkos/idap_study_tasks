import UIKit

class TaskTableViewController: UIViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate {

    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = TaskTableView
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func addRowButton(_ sender: Any) {
        self.stringArray.append(String.generate(letters: Alphabets.en.rawValue, maxRange: 15))
        self.indexOfSelectedRow = nil
    }
    @IBAction func removeRowButton(_ sender: Any) {
        if let index = self.indexOfSelectedRow {
            self.stringArray.remove(at: index)
            self.indexOfSelectedRow = nil
        }
    }
    @IBAction func sortRowsButton(_ sender: Any) {
        self.stringArray = self.stringArray.sorted(by: <)
        self.indexOfSelectedRow = nil
    }
    
    // MARK: -
    // MARK: Variables
    
    var stringArray: StringDataArray = [] {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    var indexOfSelectedRow: Int?
    
    // MARK: -
    // MARK: Overrided
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.tableView?.register(cellClass: TaskTableViewCell.self)
    }
    
    // MARK: -
    // MARK: Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.stringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: TaskTableViewCell.self)
        cell.fill(word: stringArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexOfSelectedRow = indexPath.row
    }

}
