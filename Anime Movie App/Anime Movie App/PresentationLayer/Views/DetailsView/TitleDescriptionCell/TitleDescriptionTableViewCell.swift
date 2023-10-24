import UIKit

class TitleDescriptionTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    static let cellIdentifier = String(describing: TitleDescriptionTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(title: String?, description: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    private func setupView() {
        titleLabel.font = .roundedCallout
        descriptionLabel.font = .roundedCaption2
    }
}
