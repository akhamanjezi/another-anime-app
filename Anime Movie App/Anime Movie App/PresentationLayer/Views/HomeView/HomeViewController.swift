import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    @IBOutlet private weak var favouritesTableView: UITableView!
    @IBOutlet private weak var featureImageView: UIImageView!
    @IBOutlet private weak var favouritesLabel: UILabel!
    @IBOutlet private weak var featureLabel: UILabel!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var featureAnimeView: UIView!
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCells()
        configureTableView()
        setupSearchResultsController()
        bindWithViewModel()
        configureReloadButton()
        updateFeatureAnime()
        setupFeatureAnimeTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateFavourites()
        favouritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedAnime = viewModel.favourites.value[safe: indexPath.row] else {
            return
        }
        
        pushDetailsView(for: selectedAnime)
    }
    
    private func setupView() {
        title = "Animovie"
        featureImageView.layer.cornerRadius = Constants.primaryCornerRadius
        reloadButton.layer.cornerRadius = Constants.primaryCornerRadius
        featureImageView.contentMode = .scaleAspectFill
        favouritesLabel.font = .headingBold
        featureLabel.font = .subHeadingMedium
    }
    
    private func registerCells() {
        favouritesTableView.registerNib(named: SearchTableViewCell.cellIdentifier)
    }
    
    private func configureTableView() {
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
    }
    
    private func setupSearchResultsController() {
        let searchTableViewController = SearchTableViewController()
        let searchController = UISearchController(searchResultsController: searchTableViewController)
        
        searchController.delegate = searchTableViewController
        searchController.searchBar.delegate = searchTableViewController
        searchController.obscuresBackgroundDuringPresentation = true
        
        navigationItem.searchController = searchController
    }
    
    private func bindWithViewModel() {
        viewModel.featureAnime.bind { [weak self] anime in
            self?.updateFeatureAnimeDisplay(with: anime)
        }
        
        viewModel.isFetching.bind { [weak self] fetching in
            self?.toggleFetching(fetching)
        }
    }
    
    private func configureReloadButton() {
        let reloadButtonConfigHandler: UIButton.ConfigurationUpdateHandler = { [weak self] button in
            button.configuration = (self?.viewModel.isFetching.value ?? false) ? .loadingBorderless : .reloadBorderless
        }
        reloadButton.configurationUpdateHandler = reloadButtonConfigHandler
    }
    
    private func updateFeatureAnime() {
        viewModel.newFeatureAnime()
    }
    
    private func setupFeatureAnimeTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewFeatureDetails(_:)))
        featureAnimeView.addGestureRecognizer(tap)
    }
    
    private func updateFeatureAnimeDisplay(with anime: Anime) {
        DispatchQueue.main.async {
            self.featureLabel.text = "\(anime.title) - \(anime.styledReleaseDate ?? "")"
            
            guard let coverImage = anime.coverImage else {
                self.featureImageView.configureWith(image: .defaultPlaceholder, contentMode: .center)
                return
            }
            
            self.featureImageView.configureWith(image: coverImage, contentMode: .scaleAspectFill)
        }
    }
    
    private func toggleFetching(_ fetching: Bool) {
        DispatchQueue.main.async {
            self.reloadButton.isEnabled = !fetching
            self.reloadButton.updateConfiguration()
        }
    }
    
    @objc private func viewFeatureDetails(_ sender: UITapGestureRecognizer? = nil) {
        pushDetailsView(for: viewModel.featureAnime.value)
    }
    
    @IBAction private func refreshAnime(_ sender: Any) {
        updateFeatureAnime()
    }
    
    private func pushDetailsView(for anime: Anime) {
        let detailsViewModel = DetailsViewModel(anime: anime)
        let detailsViewController = DetailsViewController(with: detailsViewModel)
        
        navigationController?.pushViewController(detailsViewController, animated: true)
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
}
