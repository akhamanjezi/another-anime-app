import UIKit

class SearchTableViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    private var dataSource: UITableViewDiffableDataSource<Section, Anime>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCell()
        bindWithViewModel()
        setupDataSource()
    }
    
    private func setupView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.delegate = self
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
    }
    
    private func bindWithViewModel() {
        viewModel.animeSearchResults.bind { [weak self] searchResults in
            guard self?.viewModel.currentSearchTerm == searchResults.term else {
                return
            }
            self?.updateDataSource()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnime = viewModel.animeSearchResults.value[indexPath.row]
        let detailsViewModel = DetailsViewModel(anime: selectedAnime)
        let detailsViewController = DetailsViewController(with: detailsViewModel)
        
        self.presentingViewController?.navigationController?.pushViewController(detailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func updateDataSource() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Anime>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(viewModel.animeSearchResults.value.results)
        DispatchQueue.main.async {
            self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Anime>(tableView: tableView, cellProvider: resultCellProvider)
        dataSource.defaultRowAnimation = .fade
    }
    
    private var resultCellProvider: UITableViewDiffableDataSource<Section, Anime>.CellProvider {
        return { [weak self]
            (tableView: UITableView, indexPath: IndexPath, item: Anime) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath)  as! SearchTableViewCell
            
            self?.viewModel.downloadImage(for: item) { image in
                self?.updateImageAndApplySnapshot(for: item, with: image)
            }
            
            cell.configureCell(for: item)
            return cell
        }
    }
    
    private func updateImageAndApplySnapshot(for anime: Anime, with image: UIImage?) {
        guard let img = image, img != anime.posterImage else {
            return
        }
        
        var updatedSnapshot = dataSource.snapshot()
        
        guard let datasourceIndex = updatedSnapshot.indexOfItem(anime) else {
            return
        }
        
        guard let item = viewModel.animeSearchResults.value.results[safe: datasourceIndex],
              item == anime else {
            return
        }
        
        item.posterImage = img
        
        updatedSnapshot.reloadItems([item])
        DispatchQueue.main.async {
            self.dataSource.apply(updatedSnapshot, animatingDifferences: false)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.animeSearchResults.value.results.count
    }
}

extension SearchTableViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.cancelSearch()
            return
        }
        
        viewModel.searchQueue.cancelAllOperations()
        viewModel.searchQueue.addOperation { [weak self] in
            self?.viewModel.search(for: searchText)
        }
    }
}
