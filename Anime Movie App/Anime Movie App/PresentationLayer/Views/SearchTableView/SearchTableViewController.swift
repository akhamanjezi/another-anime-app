import UIKit

class SearchTableViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    private var dataSource: UITableViewDiffableDataSource<Section, Anime>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCells()
        bindWithViewModel()
        setupDataSource()
    }
    
    private func setupView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.delegate = self
    }
    
    private func registerCells() {
        tableView.registerNib(named: SearchTableViewCell.cellIdentifier)
    }
    
    private func bindWithViewModel() {
        viewModel.animeSearchResults.bind { [weak self] searchResults in
            guard let searchTermKey = self?.searchTermKey,
                  searchResults[searchTermKey] != nil else {
                return
            }
            self?.updateDataSource()
        }
        
        viewModel.isSearching.bind { [weak self] isSearching in
            if !isSearching {
                self?.updateDataSource()
            }
        }
    }
    
    private var searchTermKey: String {
        viewModel.searchTerm.lowercased()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedAnime = viewModel.animeSearchResults.value[searchTermKey]?[indexPath.row] else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let detailsViewModel = DetailsViewModel(anime: selectedAnime, searchTerm: viewModel.searchTerm)
        let detailsViewController = DetailsViewController(with: detailsViewModel)
        
        self.presentingViewController?.navigationController?.pushViewController(detailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func updateDataSource() {
        guard let newResults = viewModel.animeSearchResults.value[searchTermKey] else {
            return
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Anime>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(newResults)
        
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
        
        guard let dataSourceIndex = updatedSnapshot.indexOfItem(anime) else {
            return
        }
        
        guard let item = viewModel.animeSearchResults.value[searchTermKey]?[safe: dataSourceIndex],
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
        guard let count =  viewModel.animeSearchResults.value[searchTermKey]?.count else {
            return 0
        }
        return count
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
