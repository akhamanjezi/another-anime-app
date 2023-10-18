import UIKit

class ImageDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    
    static let cellIdentifier = "imageDescriptionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        descriptionLabel.font = .roundedCallout
        posterImage.layer.cornerRadius = 7
        posterImage.contentMode = .scaleAspectFill
    }
    
    func configureCell(for anime: Anime) {
        self.descriptionLabel.attributedText = decriptionText(for: anime)
        self.posterImage.image = anime.posterImage
    }
    
    private func decriptionText(for anime: Anime) -> NSMutableAttributedString {
        let decriptionText = NSMutableAttributedString()
        decriptionText.append(applyFont(.roundedCallout, to: anime.title))
        decriptionText.append(applyFont(.roundedCallout, to: "\n"))
        decriptionText.append(applyFont(.roundedCaption2, to: anime.styledReleaseDate))
        return decriptionText
    }
    
    private func applyFont(_ font: UIFont, to string: String?) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: string ?? "",
            attributes: [NSAttributedString.Key.font:font]
        )
    }
}
