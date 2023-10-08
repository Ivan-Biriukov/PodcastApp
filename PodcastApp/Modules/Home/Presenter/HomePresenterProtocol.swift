import Foundation

protocol HomePresenterProtocol {
    func viewDidLoad()
    func didTapedSeeAllCategoryes()
    func didTapesTopGenresSeeAll()
    func didTapedSearchButton(text: String, results: Int)
}
