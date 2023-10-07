import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let router: HomeRouterInput
    private let network: NetworkManagerProtocol = NetworkManager()
    private var currentSelectedHomeViewCategyName : String = ""
    
    init(router: HomeRouterInput) {
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func didTapedSearchButton(text: String, results: Int) {
        fetchSearchResults(searchText: text, resultsCount: results)
    }
    
    
    func didTapesTopGenresSeeAll() {
        print("Did Taped top genres see all")
    }
    
    func viewDidLoad() {
        fetchMainViewContollerPreloads()

    }
    
    func updateCurrentCategoryName(with text: String) {
      //  self.currentSelectedHomeViewCategyName = text
    }
    
    func didTapedSeeAllCategoryes() {
        print("Did Taped See all categoryes")
    }
}

private extension HomePresenter {
    
    // MARK: - Network Section
    
    func fetchMainViewContollerPreloads() {
        var trendingsNamesViewModel : [AllCategoryesViewModel] = []
        var tableViewViewModel : [HomeViewCategoryTableViewModel] = []
        var popularsCategoryes : [CategoryViewModel] = []
        var randomTenCategoryes : [String] = []
        var searchViewTops : [SearchGenresViewModel] = []
        var searchViewAll : [SearchGenresViewModel] = []
        
        let group = DispatchGroup()
        let secondGroup = DispatchGroup()
        
        group.enter()
        network.fetchTrending(safe: true) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let trendings = try JSONDecoder().decode(TrendingsNamesModel.self, from: data)
                    
                    for result in  trendings.feeds {
                        trendingsNamesViewModel.append(AllCategoryesViewModel(id: result.id, categoryName: result.name, isItemSelected: false, action: {self?.updateTableViewData(queryText: result.name, resultsCount: 10)}))
                        searchViewAll.append(SearchGenresViewModel(categoryName: result.name, action: {print(result.id)}))
                    }
                }
                catch {
                    print(error)
                }
            case .failure(let e):
                print(e)
            }
            group.leave()
        }

        group.wait()
        
        if trendingsNamesViewModel.count != 0 {
            trendingsNamesViewModel[0].isItemSelected = true
        }
        view?.preloadTrending(viewModel: trendingsNamesViewModel)
        for _ in 0...10 {
            let randomeIndex : Int = Int.random(in: 0..<trendingsNamesViewModel.count)
            randomTenCategoryes.append(trendingsNamesViewModel[randomeIndex].categoryName)
        }
        
        secondGroup.enter()
        network.fetchResultsFromSelectedTrendings(categoryName: trendingsNamesViewModel[0].categoryName, count: 5) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let currentData = try JSONDecoder().decode(SearchResultModel.self, from: data)
                    
                    for i in currentData.feeds {
//                        tableViewViewModel.append(HomeViewCategoryTableViewModel(imageURLString: i.image, podcastName: i.title, authorName: i.author, podcastCategoryName: trendingsNamesViewModel[0].categoryName, episodsCount: "\(i.episodeCount)", savedToFavorits: false, action: {self?.getEpisodesDetail(episodeId: "\(i.id)", resultsCount: 1000)}))
                        tableViewViewModel.append(HomeViewCategoryTableViewModel(imageURLString: i.image, podcastName: i.title, authorName: i.author, podcastCategoryName: trendingsNamesViewModel[0].categoryName, episodsCount: "\(i.episodeCount)", savedToFavorits: false, action: {self?.transferToChannelVC(feedId: "\(i.id)")}))
                    }
                }
                catch {
                    print(error)
                }
            case .failure(let e):
                print(e)
            }
            secondGroup.leave()
        }
        
        for name in randomTenCategoryes {
            secondGroup.enter()
            network.fetchResultsFromSelectedTrendings(categoryName: name, count: 1000) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let serachResults = try JSONDecoder().decode(SearchResultModel.self, from: data)
                        
                        popularsCategoryes.append(CategoryViewModel(genreTitle: name, podcastCount: "\(Int.random(in: 10...1056))", backgroundColor: .link, action: {print(123)}))
                        searchViewTops.append(SearchGenresViewModel(categoryName: name, action: {print(serachResults.feeds.count)}))
                    }
                    catch {
                        print(error)
                    }
                case .failure(let e):
                    print(e)
                }
            }
            secondGroup.leave()
        }
        
        secondGroup.wait()
        view?.preloadHomeViewTableViewResults(viewModels: tableViewViewModel)
        view?.updateMainCategoryCollection(viewModels: popularsCategoryes)
        view?.updateSearchCollections(topViewModels: searchViewTops, allViewModels: searchViewAll)
    }


    func fetchSearchViewCategoryes() {
        
    }
    
    func fetchSearchResults(searchText: String, resultsCount: Int) {
        let group = DispatchGroup()
        
        var oneResult : [SearchResultViewModel] = []
        var allResults : [SearchResultAllPodcastsViewModel] = []
        
        group.enter()
        NetworkManager().fetchFromSearchRequest(requestText: searchText, resultsCount: resultsCount) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let feedBacks = try JSONDecoder().decode(SearchResultModel.self, from: data)
                    oneResult.append(SearchResultViewModel(imageURLString: feedBacks.feeds.first?.image ?? "", podcastGroupName: feedBacks.feeds.first?.title ?? "No results", episodsCount: "\(feedBacks.feeds.first?.episodeCount ?? 0)", authorName: feedBacks.feeds.first?.author ?? "try aghain", action: {print(12323523523325)}))
                    for feedBack in feedBacks.feeds.dropFirst() {
                        allResults.append(SearchResultAllPodcastsViewModel(imageURLString: feedBack.image, podcastName: feedBack.title, trackDuration: feedBack.language, episodeNumber: "1", action: {print("fgdsdsdffdsdsf")}))
                    }
                }
                catch {
                    print(error)
                }
            case .failure(let e):
                print(e)
            }
            group.leave()
        }
        group.wait()
        view?.presentSearchResultvC(currentResultviewModel: oneResult, allResultsViewModels: allResults, searchText: searchText)
    }
    
    // MARK: - CategoriesNames Closure Function
    
    private func updateTableViewData(queryText: String, resultsCount: Int) {
        var viewModels : [HomeViewCategoryTableViewModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.fetchResultsFromSelectedTrendings(categoryName: queryText, count: resultsCount) { [weak self] result in
            switch result {
            case.success(let data):
                do {
                    let elements = try JSONDecoder().decode(SearchResultModel.self, from: data)
                    
                    for element in elements.feeds {
                        viewModels.append(HomeViewCategoryTableViewModel(imageURLString: element.image, podcastName: element.title, authorName: element.author, podcastCategoryName: queryText, episodsCount: "\(element.episodeCount)", savedToFavorits: false, action: {self?.transferToChannelVC(feedId: "\(element.id)")}))
                    }
                }
                catch {
                    print(error)
                }
            case .failure(let e):
                print(e)
            }
            group.leave()
        }
        group.wait()
        view?.updateTableView(viewModels: viewModels)
    }
    
    // MARK: - Figure to detail episodes closure func
    
    private func getEpisodesDetail(episodeId : String, resultsCount: Int) {
        var fetchedDataArray = EpisodeDetailModel(items: [Item(id: 1, title: "", description: "", enclosureUrl: "", enclosureType: "", duration: 0, episode: 0, feedImage: "", feedId: 0, feedLanguage: "")], count: 0, query: "")
        let group = DispatchGroup()
        
        group.enter()
        network.fetchEpisodsDetail(feedID: episodeId, max: resultsCount) { [weak self] result in
            switch result {
            case.success(let data):
                do {
                    let episodes = try JSONDecoder().decode(EpisodeDetailModel.self, from: data)
                    fetchedDataArray = episodes
                }
                catch {
                    print(error)
                }
            case.failure(let e):
                print(e)
            }
            group.leave()
        }
        
        group.wait()
        print(fetchedDataArray.items.count)
        // here update view
    }
    
    
    private func transferToChannelVC(feedId : String) {
        var viewModels = ChannelCellViewModel(channelImgURLString: "", channelName: "", episodes: [Episode(episodeImgURLString: "", soundUrlString: "", name: "", timeDuration: 0, episodesCount: "", id: 0, action: { print("goToPlayer") })])
        
        var ressults : [Episode] = []
        let group = DispatchGroup()
        
        group.enter()
        network.fetchEpisodsDetail(feedID: feedId, max: 1000) { [weak self] result in
            switch result {
            case.success(let data):
                do {
                    let episodes = try JSONDecoder().decode(EpisodeDetailModel.self, from: data)
                    for episode in episodes.items {
                        ressults.append(Episode(episodeImgURLString: episode.feedImage, soundUrlString: "", name: episode.title, timeDuration: episode.duration, episodesCount: "\(episodes.count)", id: episode.id, action: { self?.view?.pushPlayerVC(tracks: [episode.enclosureUrl]); print("print from closure") } ))
                    }
                    viewModels.episodes = ressults
                }
                catch {
                    print(error)
                }
            case.failure(let e):
                print(e)
            }
            group.leave()
        }
        group.wait()
        
        view?.presentChannelVC(viewModels: viewModels)
    }
}

