import UIKit

class ImageDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    
    static let cellIdentifier = String(describing: ImageDescriptionTableViewCell.self)
    
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
        let f = DateComponentsFormatter()
        f.unitsStyle = .brief
        var descriptionParts: [(UIFont, String?, UIColor?)] = [(.subHeadingMedium, anime.title, nil),
                                                              (.roundedCallout, "\n", nil),
                                                              (.roundedCaption2, anime.styledReleaseDate, nil)]
        
        guard let duration = anime.duration else {
            return buildText(from: descriptionParts)
        }
        
        descriptionParts += [(.roundedCallout, "\n", nil),
                             (.roundedCaption2, f.string(from: duration), .secondaryLabel)]
        
        return buildText(from: descriptionParts)
    }
    
    private func buildText(from parts: [(UIFont, String?, UIColor?)]) -> NSMutableAttributedString {
        let decriptionText = NSMutableAttributedString()
        for part in parts {
            decriptionText.append(applyFont(part.0, to: part.1, with: part.2 ?? .label))
        }
        return decriptionText
    }
    
    private func applyFont(_ font: UIFont, to string: String?, with textColor: UIColor = .label) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: string ?? "",
            attributes: [NSAttributedString.Key.font:font,
                         NSAttributedString.Key.foregroundColor:textColor]
        )
    }
}
