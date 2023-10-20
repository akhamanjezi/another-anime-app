import UIKit

class ImageDescriptionTableViewCell: UITableViewCell {
    typealias TextBuilderType = (font: UIFont, text: String?, color: UIColor?)
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    
    static let cellIdentifier = String(describing: ImageDescriptionTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(for anime: Anime) {
        self.descriptionLabel.attributedText = decriptionText(for: anime)
        self.posterImage.image = anime.posterImage
    }
    
    private func setupView() {
        descriptionLabel.font = .roundedCallout
        posterImage.layer.cornerRadius = 7
        posterImage.contentMode = .scaleAspectFill
    }
    
    private func decriptionText(for anime: Anime) -> NSMutableAttributedString {
        let descriptionParts: [TextBuilderType] = Array([
            (.subHeadingMedium, anime.title, nil),
            (.roundedCaption2, anime.styledReleaseDate, nil),
            (.roundedCaption2, anime.styledDuration, .secondaryLabel),
            (.roundedCaption2, anime.styledRating, .secondaryLabel),
            (.roundedCaption2Bold, anime.ageRating, .tertiaryLabel)
        ].filter { part in
            part.text != nil
        }.map { [ $0 ] }.joined(separator: [(.roundedCallout, "\n", nil)]))
        
        return buildText(from: descriptionParts)
    }
    
    private func buildText(from parts: [TextBuilderType]) -> NSMutableAttributedString {
        let text = NSMutableAttributedString()
        for part in parts {
            text.append(applyFont(part.font, to: part.text, color: part.color ?? .label))
        }
        return text
    }
    
    private func applyFont(_ font: UIFont, to string: String?, color: UIColor = .label) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: string ?? "",
            attributes: [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.foregroundColor: color]
        )
    }
}
