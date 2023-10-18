import UIKit

class SearchTableViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    
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
        viewModel.animeSearchResults.bind { anime in
            self.updateDataSource()
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
        initialSnapshot.appendItems(viewModel.animeSearchResults.value)
        DispatchQueue.main.async {
            self.viewModel.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
    
    private func setupDataSource() {
        viewModel.dataSource = UITableViewDiffableDataSource<Section, Anime>(tableView: tableView, cellProvider: viewModel.resultCellProvider)
        viewModel.dataSource.defaultRowAnimation = .fade
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.animeSearchResults.value.count
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
