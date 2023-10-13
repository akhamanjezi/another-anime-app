import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var detailsStackView: UIStackView!
    
    static let cellIdentifier = "searchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        thumbnailView.layer.cornerRadius = 8
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .placeholderText
        backgroundView.layer.cornerRadius = 8
        self.selectedBackgroundView = backgroundView
        
        titleLabel.font = .cellTitle
        releaseDateLabel.font = .cellSubtitle
    }
}
