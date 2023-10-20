import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet private weak var detailsTableView: UITableView!
    private let viewModel: DetailsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerNibs()
        configureTableView()
    }
    
    init(with viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "DetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.navigationItem.title = viewModel.anime.title
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func registerNibs() {
        let titleDescriptionTableViewCellNib = UINib(nibName: "TitleDescriptionTableViewCell", bundle: nil)
        detailsTableView.register(titleDescriptionTableViewCellNib, forCellReuseIdentifier: TitleDescriptionTableViewCell.cellIdentifier)
        let imageDescriptionTableViewCell = UINib(nibName: "ImageDescriptionTableViewCell", bundle: nil)
        detailsTableView.register(imageDescriptionTableViewCell, forCellReuseIdentifier: ImageDescriptionTableViewCell.cellIdentifier)
    }
    
    private func configureTableView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
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
        
        return titleDescriptionCell(for: tableView, cellForRowAt: indexPath, title: viewModel.sections[indexPath.row], description: viewModel.anime.synopsis)
    }
    
    private func imageDescriptionCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ImageDescriptionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageDescriptionTableViewCell.cellIdentifier, for: indexPath) as! ImageDescriptionTableViewCell
        cell.configureCell(for: viewModel.anime)
        return cell
    }
    
    private func titleDescriptionCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath, title: String, description: String?) -> TitleDescriptionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleDescriptionTableViewCell.cellIdentifier, for: indexPath) as! TitleDescriptionTableViewCell
        cell.configureCell(title: title, description: description?.withDoubleLineBreaks())
        return cell
    }
}
