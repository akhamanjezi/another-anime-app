import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var detailsStackView: UIStackView!
    
    static let cellIdentifier = String(describing: SearchTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupSelectedBackgorundView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(for anime: Anime) {
        titleLabel.text = anime.title
        configureThumbnailView(for: anime)
        configureReleaseDateLabel(for: anime)
    }
    
    private func setupView() {
        thumbnailView.layer.cornerRadius = 8
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        titleLabel.font = .roundedCallout
        releaseDateLabel.font = .roundedCaption2
        
        thumbnailView.contentMode = .scaleAspectFill
    }
    
    private func setupSelectedBackgorundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .placeholderText
        backgroundView.layer.cornerRadius = 8
        selectedBackgroundView = backgroundView
    }
    
    private func configureThumbnailView(for anime: Anime) {
        guard let thumbnailImage = anime.posterImage ?? anime.thumbnail else {
            thumbnailView.configureWith(image: .defaultPlaceholder, contentMode: .center)
            return
        }
        thumbnailView.configureWith(image: thumbnailImage, contentMode: .scaleAspectFill)
    }
    
    private func configureReleaseDateLabel(for anime: Anime) {
        guard let displayReleaseDate = anime.styledReleaseDate else {
            releaseDateLabel.isHidden = true
            return
        }
        releaseDateLabel.isHidden = false
        releaseDateLabel.text = displayReleaseDate
    }
}

