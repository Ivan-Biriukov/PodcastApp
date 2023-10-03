import Foundation

protocol HomeViewInput: AnyObject {
    func preloadTrending(viewModel: [AllCategoryesViewModel])
    func preloadHomeViewTableViewResults(viewModels: [HomeViewCategoryTableViewModel])
    
    
    func updateMainCategoryCollection(viewModels: [CategoryViewModel])
    func updateAllCategoryes(viewModels: [AllCategoryesViewModel])
    func updateTableView(viewModels: [HomeViewCategoryTableViewModel])
   // func updateTableViewDataWithCurrentCategori(viewModels: [HomeViewCategoryTableViewModel])
    func updateSearchCollections(topViewModels:[SearchGenresViewModel] , allViewModels: [SearchGenresViewModel])
}
