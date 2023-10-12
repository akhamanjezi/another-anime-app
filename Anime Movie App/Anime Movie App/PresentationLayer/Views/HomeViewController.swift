import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var searchButton: UIButton!
    
    @IBOutlet private weak var searchTextField: UITextField!
    
    @IBOutlet private weak var resultCountLabel: UILabel!
    
    @IBAction private func tappedSearchButton(_ sender: Any) {
        if (searchTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        
        viewModel.search(for: searchTextField.text ?? "")
    }
    
    private let viewModel = HomeViewModel(animeRepository: KitsuRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindWithViewModel()
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
    
    private func setupView() {
        self.title = "Animovie"
    }
}
