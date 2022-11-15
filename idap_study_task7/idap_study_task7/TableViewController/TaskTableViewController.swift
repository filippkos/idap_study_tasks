import UIKit

class TaskTableViewController: UIViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate {

    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = TaskTableView
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func addRowButton(_ sender: Any) {
        self.stringArray.append(atributedText())
        self.indexOfSelectedRow = nil
    }
    
    @IBAction func removeRowButton(_ sender: Any) {
        if let index = self.indexOfSelectedRow {
            self.stringArray.remove(at: index)
            self.indexOfSelectedRow = nil
        }
    }
    
    @IBAction func sortRowsButton(_ sender: Any) {
        self.stringArray = self.stringArray.sorted{ $0.string < $1.string }
        self.indexOfSelectedRow = nil
    }
    
    // MARK: -
    // MARK: Variables
    
    var stringArray: StringDataArray {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    var indexOfSelectedRow: Int?
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(stringArray: StringDataArray) {
        self.stringArray = stringArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Private
    
    func atributedText() -> NSMutableAttributedString {
        let text = String.generate(letters: .en, maxRange: 15)
        let fontAtribute = [NSAttributedString.Key.font: Fonts.TimesNewRoman.regular.size(30.0) as Any]
        return NSMutableAttributedString(string: text, attributes: fontAtribute)
    }
    
    func process(imageIn cell: TaskTableViewCell) {
        var cellImage = UIImage(named:"logoimage.png")
        let cellHeight = cell.logo?.frame.size.height
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                cell.spinner?.startAnimating()
            }
            cellImage = cellImage?.compress(cellHeight: cellHeight ?? 0)
            DispatchQueue.main.async {
                cell.add(logo: cellImage)
                cell.spinner?.stopAnimating()
                cell.spinner?.removeFromSuperview()
            }
        }
    }
    
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
        let initialId = cell.id
        if initialId == cell.id {
            self.process(imageIn: cell)
            cell.fill(word: self.stringArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexOfSelectedRow = indexPath.row
    }
}
