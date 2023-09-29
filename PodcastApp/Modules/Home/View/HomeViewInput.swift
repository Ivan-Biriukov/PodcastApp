import Foundation

protocol HomeViewInput: AnyObject {
    func updateMainCategoryCollection(viewModels: [CategoryViewModel])
    func updateAllCategoryes(viewModels: [AllCategoryesViewModel])
    func updateTableView(viewModels: [HomeViewCategoryTableViewModel])
    func updateSearchCollections(topViewModels:[AllCategoryesViewModel] , allViewModels: [AllCategoryesViewModel])
}
