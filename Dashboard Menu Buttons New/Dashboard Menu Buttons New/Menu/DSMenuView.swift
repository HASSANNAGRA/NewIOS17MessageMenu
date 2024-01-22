import UIKit
class DSMenuView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    public var firstData: [String] = []
    public var secondData: [String] = []
    
    var animationDuration: TimeInterval = 0.85
    var delay: TimeInterval = 0.05
    var currentTableAnimation: TableAnimation = .moveUpBounce(rowHeight: 65, duration: 0.85, delay: 0.03)
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewFrame = CGRect(x: 0, y: self.view.frame.height - 40, width: self.view.frame.width, height: self.view.frame.height)
        tableView.frame = tableViewFrame
        effectView.alpha = 0
        self.firstData = [
            "Camera",
            "Photos",
            "Stickers",
            "ApplePay",
            "Audio",
            "More"
        ]
        
        self.secondData = [
//            "Store",
//            "#Bilder",
//            "Wegbegleitung",
//            "Digital Touch",
//            "Memoji"
        ]
        
        tableView.decelerationRate = .init(rawValue: 23)
        tableView.delegate = self
        tableView.dataSource = self
    }
    public override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.effectView.alpha = 1
          //  self.tableView.frame = tableView.rectForRow(at: <#T##IndexPath#>)
        } completion: { _ in
            self.currentTableAnimation = TableAnimation.moveUpBounce(rowHeight: 65, duration: self.animationDuration + 0.2, delay: self.delay)
            self.tableView.reloadData()
        }
    }
    public func show() {
        UIApplication.shared.delegate?.window??.rootViewController?.present(self, animated: true)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return firstData.count
        case 3:
            return secondData.count
        default:
            return 1
        }
    }
    
    public func isSpacerCell(_ indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 1, 3:
            return false
        default:
            return true
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isSpacer = isSpacerCell(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: isSpacer ? "spacerCell" : "menuCell", for: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //let isSpacer = isSpacerCell(indexPath)
        //!isSpacer,
        if let cell = cell as? MenuCell {
            let item = (indexPath.section == 1 ? firstData : secondData)[indexPath.row]
            cell.titleField.text = item
            cell.imageField.image = UIImage(named: item)
            let animation = currentTableAnimation.getAnimation()
            let animator = TableViewAnimator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
//        switch indexPath.section {
//        case 0:
//            return max(0, tableView.bounds.height - CGFloat(65 * firstData.count) - 65)
//        case 1:
//            return 65
//        case 2:
//            return max(0, tableView.bounds.height - CGFloat(65 * secondData.count))
//        case 3:
//            return 65
//        case 4:
//            return 65
//        default:
//            return 0
//        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let isSpacer = isSpacerCell(indexPath)
        dismiss(animated: true)
        
//        if isSpacer {
//            
//        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = CGPoint(
            x: targetContentOffset.pointee.x,
            y: round(targetContentOffset.pointee.y / UIScreen.main.bounds.height) * UIScreen.main.bounds.height
        )
    }

}

class MenuCell: UITableViewCell {
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var titleField: UILabel!
}
