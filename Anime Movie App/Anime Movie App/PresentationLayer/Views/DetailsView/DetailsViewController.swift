import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet private weak var detailsTableView: UITableView!
    private let viewModel: DetailsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCells()
        configureTableView()
        bindWithViewModel()
    }
    
    init(with viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "DetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        navigationItem.title = viewModel.anime.value.title
        navigationItem.largeTitleDisplayMode = .never
        configureBackButton()
        configureFavouriteButton()
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = viewModel.searchTerm == nil ? "Animovie" : viewModel.searchTerm!.truncateTo(length: 6)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func configureFavouriteButton() {
        let favouriteImage = UIImage(systemName: "star\(viewModel.isFavorite ? ".fill" : "")")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(scale: .medium))
        let favouriteButton = UIBarButtonItem(image: favouriteImage, style: .plain, target: self, action: #selector(favouriteButtonTapped))
        DispatchQueue.main.async {
            self.navigationItem.setRightBarButton(favouriteButton, animated: true)
        }
    }
    
    @objc private func favouriteButtonTapped() {
        viewModel.toggleFavorite() { [weak self] in
            self?.configureFavouriteButton()
        }
    }
    
    private func registerCells() {
        detailsTableView.registerNib(named: TitleDescriptionTableViewCell.cellIdentifier)
        detailsTableView.registerNib(named: ImageDescriptionTableViewCell.cellIdentifier)
    }
    
    private func configureTableView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    private func bindWithViewModel() {
        viewModel.anime.bind { [weak self] anime in
            DispatchQueue.main.async {
                self?.detailsTableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return imageDescriptionCell(for: tableView, cellForRowAt: indexPath)
        }
        
        return titleDescriptionCell(for: tableView, cellForRowAt: indexPath, title: viewModel.sections[indexPath.row], description: viewModel.anime.value.synopsis)
    }
    
    private func imageDescriptionCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ImageDescriptionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageDescriptionTableViewCell.cellIdentifier, for: indexPath) as! ImageDescriptionTableViewCell
        cell.configureCell(for: viewModel.anime.value)
        return cell
    }
    
    private func titleDescriptionCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath, title: String, description: String?) -> TitleDescriptionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleDescriptionTableViewCell.cellIdentifier, for: indexPath) as! TitleDescriptionTableViewCell
        cell.configureCell(title: title, description: description?.withDoubleLineBreaks())
        return cell
    }
}
