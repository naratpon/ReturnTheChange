import UIKit

class TitleReturnMoneyTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var titleValueLabel: UILabel!
    @IBOutlet weak var amountValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
    }
    
    func configure(title: String, amount: String) {
        self.titleValueLabel.text = title
        self.amountValueLabel.text = amount
    }

    
}
