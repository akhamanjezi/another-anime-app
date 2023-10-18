import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var detailsStackView: UIStackView!
    
    static let cellIdentifier = "searchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(for anime: Anime) {
        titleLabel.text = anime.title
        releaseDateLabel.text = anime.styledReleaseDate
        thumbnailView.image = anime.posterImage
        thumbnailView.contentMode = .scaleAspectFill
        
        guard let displayReleaseDate = anime.styledReleaseDate else {
            self.releaseDateLabel.isHidden = true
            return
        }
        
        self.releaseDateLabel.isHidden = false
        self.releaseDateLabel.text = displayReleaseDate
    }
    
    private func setupView() {
        thumbnailView.layer.cornerRadius = 8
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .placeholderText
        backgroundView.layer.cornerRadius = 8
        self.selectedBackgroundView = backgroundView
        
        titleLabel.font = .roundedCallout
        releaseDateLabel.font = .roundedCaption2
        
        thumbnailView.contentMode = .scaleAspectFill
    }
}
