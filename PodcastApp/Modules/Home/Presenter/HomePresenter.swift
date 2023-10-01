import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let router: HomeRouterInput
    private let network: NetworkManagerProtocol = NetworkManager()
    
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
        fetchCategoryesNames()
        fetchTableViewCategory()
        fetchSearchViewCategoryes()
    }
    
    func didTapedSeeAllCategoryes() {
        print("Did Taped See all categoryes")
    }
}

private extension HomePresenter {
    
    func fetchMainCategoryes() {
        let topGenresIdsArray: [String] = ["144", "151", "93", "77", "125", "122", "127", "132", "168", "88", "134", "99", "133", "100", "69", "117", "68", "82", "111", "107", "135"]

        var homeViewPopularCategories : [CategoryViewModel] = []
        let group = DispatchGroup()

        for id in topGenresIdsArray{
            group.enter()
            network.fetchHomeViewPopularCategories(genreId: id, pageNumber: 1) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let genres = try JSONDecoder().decode(TopGenresModel.self, from: data)
                        homeViewPopularCategories.append(CategoryViewModel(genreTitle: genres.name, podcastCount: "\(genres.total)", backgroundColor: .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1), action: {print(genres.name)}))
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }
        }
        group.wait()
        view?.updateMainCategoryCollection(viewModels: homeViewPopularCategories)
    }
    
    func fetchCategoryesNames() {
        var homeNamesViewModel : [AllCategoryesViewModel] = []
        var searchTopNamesViewModel : [SearchGenresViewModel] = []
        var searchAllGenresViewModel : [SearchGenresViewModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.fetchCategoriest(page: 1) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let genres = try JSONDecoder().decode(GenresModel.self, from: data)
                    for i in genres.genres {
                        searchTopNamesViewModel.append(SearchGenresViewModel(categoryName: i.name, action: {print( i.id)}))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        group.leave()
        }
        
        group.enter()
        network.fetchCategoriest(page: 0) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let genres = try JSONDecoder().decode(GenresModel.self, from: data)
                    for i in genres.genres {
                        homeNamesViewModel.append(AllCategoryesViewModel(id: i.id, categoryName: i.name, isItemSelected: false, action: {print(i.id)}))
                        searchAllGenresViewModel.append(SearchGenresViewModel(categoryName: i.name, action: {print(i.id)}))
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.wait()
        homeNamesViewModel[0].isItemSelected = true
        view?.updateAllCategoryes(viewModels: homeNamesViewModel)
        view?.updateSearchCollections(topViewModels: searchTopNamesViewModel, allViewModels: searchAllGenresViewModel)
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
        
    }
}
