import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var resultCountLabel: UILabel!
    
    @IBAction func tappedSearchButton(_ sender: Any) {
        if (searchTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        
        viewModel.search(for: searchTextField.text ?? "")
    }
    
    let viewModel = HomeViewModel(animeRepository: KitsuRespository(dataProvider: KitsuProvider()))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindWithViewModel()
    }
    
    func bindWithViewModel() {
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
    
    func setupView() {
        self.title = "Animovie"
    }
}
