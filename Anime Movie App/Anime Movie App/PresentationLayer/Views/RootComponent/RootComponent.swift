import UIKit
import NeedleFoundation

class RootComponent: BootstrapComponent {
    var rootView: UINavigationController {
        MainNavigationController(rootViewController: homeComponent.homeViewController)
    }
    
    var homeComponent: HomeComponent {
        HomeComponent(parent: self)
    }
    
    public var homeViewModel: HomeViewModel {
        HomeViewModel(animeRepository: animeRepository)
    }
    
    var animeRepository: AnimeRepository {
        KitsuRepository(dataProvider: dataProvider,
                        toAnimeMapper: toAnimeMapper,
                        imageRepository: imageRepository,
                        favouritesManager: favouritesManager)
    }
    
    private var dataProvider: DataProviding {
        KitsuProvider()
    }
    
    private var toAnimeMapper: any ToAnimeMapper<KitsuResult> {
        KitsuResultToAnimeMapper()
    }
    
    private var imageRepository: any ImageRepository {
        ImageRepo(imageDownloader: imageDownloader,
                  storage: imageStorage)
    }
    
    private var imageDownloader: ImageDownloading {
        ImageDownloader()
    }
    
    private var imageStorage: any ImageStoring<NSURL, UIImage> {
        shared {
            ImageCache(cache: NSCache<NSURL, UIImage>())
        }
    }
    
    private var favouritesManager: any FavouritesManaging {
        FavouritesManager(storage: favouritesStorage,
                          mapper: savedAnimeToAnimeMapper)
    }
    
    private var favouritesStorage: any DataStoring<String, Data> {
        shared {
            FavouritesStorage(storage: UserDefaults.standard)
        }
    }
    
    private var savedAnimeToAnimeMapper: any BidirectionalAnimeMapping<SavedAnime> {
        SavedAnimeToAnimeMapper()
    }
}
