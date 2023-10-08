import Foundation

protocol HomeViewInput: AnyObject {
    func preloadTrending(viewModel: [AllCategoryesViewModel])
    func preloadHomeViewTableViewResults(viewModels: [HomeViewCategoryTableViewModel])
    func presentSearchResultvC(currentResultviewModel: [SearchResultViewModel], allResultsViewModels: [SearchResultAllPodcastsViewModel], searchText: String)
    func presentChannelVC(viewModels : ChannelCellViewModel)
    func pushPlayerVC(tracks: [String], track: String, author: String)
    
    
    func updateMainCategoryCollection(viewModels: [CategoryViewModel])
    func updateAllCategoryes(viewModels: [AllCategoryesViewModel])
    func updateTableView(viewModels: [HomeViewCategoryTableViewModel])
    func updateSearchCollections(topViewModels:[SearchGenresViewModel] , allViewModels: [SearchGenresViewModel])
}
