import UIKit

class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel(animeRepository: KitsuRepository())
    
    @IBOutlet private weak var searchButton: UIButton!
    
    @IBOutlet private weak var searchTextField: UITextField!
    
    @IBOutlet private weak var resultCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindWithViewModel()
    }
    
    private func setupView() {
        self.title = "Animovie"
    }
    
    private func bindWithViewModel() {
        viewModel.animeSearchResults.bind { anime in
            DispatchQueue.main.async {
                self.resultCountLabel.text = "\(anime.count) search results"
            }
        }
        
        viewModel.isSearching.bind { isSearching in
            DispatchQueue.main.async {
                self.searchButton.isEnabled = !isSearching
            }
        }
    }
    
    @IBAction private func tappedSearchButton(_ sender: Any) {
        let searchTerm = (searchTextField.text ?? "")
        if searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        
        viewModel.search(for: searchTerm)
    }
}
