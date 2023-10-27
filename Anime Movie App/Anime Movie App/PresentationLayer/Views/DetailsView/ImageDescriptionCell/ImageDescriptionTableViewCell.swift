import UIKit

class ImageDescriptionTableViewCell: UITableViewCell {
    typealias TextBuilderType = (font: UIFont, text: String?, color: UIColor?)
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    static let cellIdentifier = String(describing: ImageDescriptionTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(for anime: Anime) {
        descriptionLabel.attributedText = decriptionText(for: anime)
        guard let posterImage = (anime.posterImage ?? anime.coverImage) else {
            activityIndicatorView.startAnimating()
            return
        }
        activityIndicatorView.stopAnimating()
        posterImageView.image = posterImage
    }
    
    private func setupView() {
        descriptionLabel.font = .roundedCallout
        posterImageView.layer.cornerRadius = 7
        posterImageView.contentMode = .scaleAspectFill
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
            text.append(attributedString(part.text, font: part.font, color: part.color))
        }
        return text
    }
    
    private func attributedString(_ string: String?, font: UIFont, color: UIColor?) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: string ?? "",
            attributes: [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.foregroundColor: color ?? .label]
        )
    }
}
