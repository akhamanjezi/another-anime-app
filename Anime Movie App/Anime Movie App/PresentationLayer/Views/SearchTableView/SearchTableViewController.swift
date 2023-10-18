import UIKit

class SearchTableViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCell()
        bindWithViewModel()
        setupDatasource()
    }
    
    fileprivate func setupView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
    }
    
    private func bindWithViewModel() {
        viewModel.animeSearchResults.bind { anime in
            self.updateDatasource()
        }
    }
    
    private func updateDatasource() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Anime>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(viewModel.animeSearchResults.value)
        DispatchQueue.main.async {
            self.viewModel.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
    
    private func setupDatasource() {
        viewModel.dataSource = UITableViewDiffableDataSource<Section, Anime>(tableView: tableView) { [weak self]
            (tableView: UITableView, indexPath: IndexPath, item: Anime) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath)  as! SearchTableViewCell
            
            self?.viewModel.downloadImage(from: NSURL(string: item.posterImageURL ?? "")!, for: item)
            cell.configureCell(for: item)
            return cell
        }
        
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
