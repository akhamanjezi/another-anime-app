import UIKit

class SearchTableViewController: UITableViewController {
    private let viewModel = SearchTableViewModel(animeRepository: KitsuRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCell()
        bindWithViewModel()
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.animeSearchResults.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < viewModel.animeSearchResults.value.count else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        let animeSearchResult = viewModel.animeSearchResults.value[indexPath.row]
        cell.configureCell(for: animeSearchResult)
        return cell
    }
}

fileprivate extension SearchTableViewCell {
    func configureCell(for anime: Anime) {
        self.titleLabel.text = anime.title
        guard let displayReleaseDate = anime.styledReleaseDate else {
            return
        }
        
        self.releaseDateLabel.text = displayReleaseDate
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
