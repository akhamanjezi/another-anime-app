import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    private let viewModel = HomeViewModel(animeRepository: KitsuRepository(), imageRepository: ImageRepository())
    @IBOutlet private weak var favouritesTableView: UITableView!
    @IBOutlet private weak var featureImageView: UIImageView!
    @IBOutlet private weak var favouritesLabel: UILabel!
    @IBOutlet private weak var featureLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerNib()
        setupSearchResultsController()
        bindWithViewModel()
        configureReloadButton()
        updateFeatureAnime()
    }
    
    private func setupView() {
        self.title = "Animovie"
        featureImageView.layer.cornerRadius = 8
        reloadButton.layer.cornerRadius = 8
        featureImageView.contentMode = .scaleAspectFill
        favouritesLabel.font = .sectionTitle
        featureLabel.font = .featureTitle
    }
    
    private func registerNib() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        favouritesTableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
        
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
    }
    
    private func setupSearchResultsController() {
        let searchTableViewController = SearchTableViewController()
        let searchController = UISearchController(searchResultsController: searchTableViewController)
        
        searchController.delegate = searchTableViewController
        searchController.searchBar.delegate = searchTableViewController
        
        self.navigationItem.searchController = searchController
    }
    
    private func bindWithViewModel() {
        viewModel.featureAnime.bind { [weak self] anime in
            self?.updateFeatureAnimeDisplay(with: anime ?? Anime.placeholder)
        }
        
        viewModel.isFetching.bind { [weak self] fetching in
            self?.toggleFetching(fetching)
        }
    }
    
    private func updateFeatureAnimeDisplay(with anime: Anime) {
        DispatchQueue.main.async {
            self.featureLabel.text = "\(anime.title ?? "") - \(anime.styledReleaseDate ?? "")"
            self.featureImageView.image = anime.coverImage
        }
    }
    
    private func toggleFetching(_ fetching: Bool) {
        DispatchQueue.main.async {
            self.reloadButton.isEnabled = !fetching
            self.reloadButton.updateConfiguration()
        }
    }
    
    private func configureReloadButton() {
        let reloadButtonConfigHandler: UIButton.ConfigurationUpdateHandler = { button in
            var reloadButtonConfig = UIButton.Configuration.borderless()
            
            if self.viewModel.isFetching.value {
                reloadButtonConfig.showsActivityIndicator = true
            } else {
                reloadButtonConfig.image = UIImage(systemName: "arrow.clockwise")
            }
            
            button.configuration = reloadButtonConfig
        }
        reloadButton.configurationUpdateHandler = reloadButtonConfigHandler
    }
    
    private func updateFeatureAnime() {
        viewModel.newFeatureAnime()
    }
    
    
    @IBAction func refreshAnime(_ sender: Any) {
        updateFeatureAnime()
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favourites.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configureCell(for: viewModel.favourites.value[indexPath.row])
        return cell
    }
    
    private func configureCell(_ cell: SearchTableViewCell, for anime: Anime) -> SearchTableViewCell {
        cell.titleLabel.text = anime.title
        cell.thumbnailView.image = UIImage(named: "posterImage")
        cell.thumbnailView.contentMode = .scaleAspectFill
        
        return cell
    }
}

// MARK: SearchTableViewCell+Extension

fileprivate extension SearchTableViewCell {
    func configureCell(for anime: Anime) {
        self.titleLabel.text = anime.title
        self.releaseDateLabel.text = anime.styledReleaseDate
        self.thumbnailView.image = UIImage(named: "posterImage")
        self.thumbnailView.contentMode = .scaleAspectFill
    }
}
