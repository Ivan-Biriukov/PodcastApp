import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let router: HomeRouterInput
    
    init(router: HomeRouterInput) {
        self.router = router
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        fetchMainCategoryes()
        fetchAllCategoryes()
        fetchTableViewCategory()
    }
    
    func didTapedSeeAllCategoryes() {
        print("Did Taped See all categoryes")
    }
    
    
}

private extension HomePresenter {
    func fetchMainCategoryes() {
        let viewModels : [CategoryViewModel] = [
            .init(genreTitle: "Music & Fun", podcastCount: "84", backgroundColor: .init(rgb: 0xFED9D6), action: {print("first cell")}),
            .init(genreTitle: "Life & Chill", podcastCount: "96", backgroundColor: .init(rgb: 0x97D7F2), action: {print(("second Cell"))}),
            .init(genreTitle: "Education", podcastCount: "72", backgroundColor: .init(rgb: 0xEDF0FC), action: {print("third Cell")})
        ]
        
        DispatchQueue.main.async {
            self.view?.updateMainCategoryCollection(viewModels: viewModels)
        }
    }
    
    func fetchAllCategoryes() {
        let viewModels : [AllCategoryesViewModel] = [
            .init(categoryName: "Popular"),
            .init(categoryName: "Recent"),
            .init(categoryName: "Music"),
            .init(categoryName: "Design"),
            .init(categoryName: "Lify"),
            .init(categoryName: "Education"),
            .init(categoryName: "Sport"),
            .init(categoryName: "Chill")
        ]
        
        DispatchQueue.main.async {
            self.view?.updateAllCategoryes(viewModels: viewModels)
        }
    }
    
    func fetchTableViewCategory() {
        let viewModels : [HomeViewCategoryTableViewModel] = [
            .init(color: .init(rgb: 0x2882F1), podcastName: "Ngobam", authorName: "Gofar Hilman", podcastCategoryName: "Music & Fun", episodsCount: "23", savedToFavorits: true, action: {print(1)}),
            .init(color: .init(rgb: 0xFEDCDB), podcastName: "Semprod", authorName: "Kuy Entertainment", podcastCategoryName: "Life & Chill", episodsCount: "44", savedToFavorits: false, action: {print(2)}),
            .init(color: .init(rgb: 0x97D7F2), podcastName: "Sruput Nendang", authorName: "Marco", podcastCategoryName: "Life & Chill", episodsCount: "46", savedToFavorits: false, action: {print(3)})
        ]
        
        DispatchQueue.main.async {
            self.view?.updateTableView(viewModels: viewModels)
        }
    }
}
