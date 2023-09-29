import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let router: HomeRouterInput
    
    init(router: HomeRouterInput) {
        self.router = router
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func didTapesTopGenresSeeAll() {
        print("Did Taped top genres see all")
    }
    
    func viewDidLoad() {
        fetchMainCategoryes()
        fetchAllCategoryes()
        fetchTableViewCategory()
        fetchSearchViewCategoryes()
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
            .init(categoryName: "Popular", action: {print("cell taped")}),
            .init(categoryName: "Recent", action: {print("cell taped")}),
            .init(categoryName: "Music", action: {print("cell taped")}),
            .init(categoryName: "Design", action: {print("cell taped")}),
            .init(categoryName: "Lify", action: {print("cell taped")}),
            .init(categoryName: "Education", action: {print("cell taped")}),
            .init(categoryName: "Sport", action: {print("cell taped")}),
            .init(categoryName: "Chill", action: {print("cell taped")})
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
    
    func fetchSearchViewCategoryes() {
        
        let allCategoryesViewModels : [AllCategoryesViewModel] = [
            .init(categoryName: "Popular", action: {print("cell taped")}),
            .init(categoryName: "Recent", action: {print("cell taped")}),
            .init(categoryName: "Music", action: {print("cell taped")}),
            .init(categoryName: "Design", action: {print("cell taped")}),
            .init(categoryName: "Lify", action: {print("cell taped")}),
            .init(categoryName: "Education", action: {print("cell taped")}),
            .init(categoryName: "Sport", action: {print("cell taped")}),
            .init(categoryName: "Chill", action: {print("cell taped")}),
            .init(categoryName: "Popular", action: {print("cell taped")}),
            .init(categoryName: "Recent", action: {print("cell taped")}),
            .init(categoryName: "Music", action: {print("cell taped")}),
            .init(categoryName: "Design", action: {print("cell taped")}),
            .init(categoryName: "Lify", action: {print("cell taped")}),
            .init(categoryName: "Education", action: {print("cell taped")}),
            .init(categoryName: "Sport", action: {print("cell taped")}),
            .init(categoryName: "Chill", action: {print("cell taped")})
        ]
        
        var topGenresViewModel = [AllCategoryesViewModel]()
        
        for (index, element) in allCategoryesViewModels.enumerated() {
            if index % 2 == 0 {
                topGenresViewModel.append(element)
            }
        }
        DispatchQueue.main.async {
            self.view?.updateSearchCollections(topViewModels: allCategoryesViewModels, allViewModels: topGenresViewModel)
        }
    }
}
