import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    private let viewModel = HomeViewModel(animeRepository: KitsuRepository())
    @IBOutlet private weak var favouritesTableView: UITableView!
    @IBOutlet private weak var featureImageView: UIImageView!
    @IBOutlet private weak var favouritesLabel: UILabel!
    @IBOutlet private weak var featureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerNib()
        setupSearchResultsController()
        bindWithViewModel()
        updateFeatureAnime()
    }
    
    private func setupView() {
        self.title = "Animovie"
        featureImageView.layer.cornerRadius = 8
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
    
    private func updateFeatureAnimeDisplay(with anime: Anime) {
        DispatchQueue.main.async {
            self.featureLabel.text = "\(anime.title ?? "") - \(anime.styledReleaseDate ?? "")"
        }
    }
    private func updateFeatureAnime() {
        viewModel.newFeatureAnime()
    }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configureCell(for: Anime(title: "Spirited Away",
                                      genres: nil,
                                      releaseDate: "2001-07-20".toDate(),
                                      synopsis: "Stubborn, spoiled, and naïve, 10-year-old Chihiro Ogino is less than pleased when she and her parents discover an abandoned amusement park on the way to their new house. Cautiously venturing inside, she realizes that there is more to this place than meets the eye, as strange things begin to happen once dusk falls. Ghostly apparitions and food that turns her parents into pigs are just the start—Chihiro has unwittingly crossed over into the spirit world. Now trapped, she must summon the courage to live and work amongst spirits, with the help of the enigmatic Haku and the cast of unique characters she meets along the way.\nVivid and intriguing, Sen to Chihiro no Kamikakushi tells the story of Chihiro's journey through an unfamiliar world as she strives to save her parents and return home.\n[Written by MAL Rewrite]",
                                      averageRating: 82.59,
                                      ageRating: "G",
                                      imageURL: "https://media.kitsu.io/anime/poster_images/176/original.jpg",
                                      thumnail: nil,
                                      duration: .seconds(60) * 125,
                                      externalID: "176",
                                      source: .kitsu))
        return cell
    }
    
    private func configureCell(_ cell: SearchTableViewCell, for anime: Anime) -> SearchTableViewCell {
        cell.titleLabel.text = anime.title
        cell.thumbnailView.image = UIImage(named: "posterImage")
        cell.thumbnailView.contentMode = .scaleAspectFill
        
        return cell
    }
}

fileprivate extension SearchTableViewCell {
    func configureCell(for anime: Anime) {
        self.titleLabel.text = anime.title
        self.releaseDateLabel.text = anime.styledReleaseDate
        self.thumbnailView.image = UIImage(named: "posterImage")
        self.thumbnailView.contentMode = .scaleAspectFill
    }
}
