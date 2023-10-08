import UIKit
import SnapKit

extension CreatePlaylistViewController {
    struct Constants {
        let textBlackColor : UIColor = .init(rgb: 0x423F51)
        let lightTextColor : UIColor = .init(rgb: 0xA3A1AF)
    }
}

class CreatePlaylistViewController: BaseViewController {
    
    // MARK: - Propertyes
    
    private let constants: Constants
    private var searchResultsViewModels : [PlaylistTableViewModel] = []
    
    // MARK: - UI Elements
    
    private lazy var backButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        btn.tintColor = constants.textBlackColor
        btn.addTarget(self, action: #selector(backTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleLabel : UILabel = {
        return createLabel(text: "Create Playlist", font: .systemFont(ofSize: 16, weight: .bold), textColor: constants.textBlackColor)
    }()
    
    private lazy var threeDotsButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(.Main.threeDotsImage, for: .normal)
        btn.tintColor = constants.textBlackColor
        btn.addTarget(self, action: #selector(dotesTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleStack : UIStackView = {
        let stack = createStackView(for: backButton, titleLabel, threeDotsButton, axis: .horizontal, spacing: 0)
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private let imageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 21
        img.image = UIImage(named: "favoritsEmptyImg")
        return img
    }()
    
    private lazy var selectImageButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(selectImageTaped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nameTextField : UITextField = {
        let field = UITextField()
        field.addBottomBorder(height: 1, color: .init(rgb: 0xE0E1E6))
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Give a name for your playlist", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(rgb: 0x918EA0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)])
        field.textColor = constants.textBlackColor
        field.font = .systemFont(ofSize: 14, weight: .regular)
        return field
    }()
    
    private lazy var searchFieldButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.Main.searchImage, for: .normal)
        btn.contentMode = .scaleToFill
        btn.tintColor = constants.lightTextColor
        btn.addTarget(self, action: #selector(searchTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var searchField : UITextField = {
        let field = UITextField()
        field.backgroundColor = .init(rgb: 0xEDF0FC)
        field.layer.cornerRadius = 12
        field.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(rgb: 0xA3A1AF), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        field.font = .systemFont(ofSize: 14, weight: .regular)
        field.textColor = .init(rgb: 0x423F51)
        field.textAlignment = .left
        field.clearButtonMode = .never
        field.rightViewMode = .always
        field.setLeftPaddingPoints(24)
        return field
    }()
    
    private lazy var searchResultsTableView : UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.register(CreatePlaylistTableViewCell.self, forCellReuseIdentifier: CreatePlaylistTableViewCell.reuseId)
        tb.separatorStyle = .none
        return tb
    }()
    
    private lazy var createButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create Playlist", for: .normal)
        btn.setTitleColor(constants.textBlackColor, for: .normal)
        btn.backgroundColor = .init(rgb: 0xEDF0FC)
        btn.layer.cornerRadius = 12
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(createTaped), for: .touchUpInside)
        return btn
    }()

    // MARK: - LifeCycleMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
        configureTextFields()
    }
    
    // MARK: - Init
    
    init() {
        self.constants = Constants()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Buttons Methods

private extension CreatePlaylistViewController {
    
    @objc func backTaped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func dotesTaped(_ sender: UIButton) {
        print("dotesTaped")
    }
    
    @objc func searchTaped(_ sender: UIButton) {
        fetchSearchResults(searchText: searchField.text!)
    }
    
    @objc func createTaped() {
        guard let vc = FavoritsAssembly.assemble() as? FavoritsViewController else {return}
        vc.playListViewModels.append(FavoritsTableViewModel(imageURLString: "", titleText: nameTextField.text!, episodesString: "12", id: 0, action: {}))
        
        vc.playlistTableView.reloadData()
    }
    
    @objc func selectImageTaped() {
        imageView.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.imageView.alpha = 1
            ImageChooseAlert.shared.showAlert(on: self)
        })
    }
}

// MARK: - Configure UI

private extension CreatePlaylistViewController {
    
    func addSubviews() {
        addSubviews(views: titleStack, imageView, selectImageButton, nameTextField, searchField, searchResultsTableView, createButton)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints {make in
            make.height.width.equalTo(24)
        }
        
        threeDotsButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(4)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(84)
            make.top.equalTo(titleStack.snp.bottom).inset(-33)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        selectImageButton.snp.makeConstraints { make in
            make.height.width.equalTo(84)
            make.top.equalTo(titleStack.snp.bottom).inset(-33)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
            make.top.equalTo(imageView.snp.bottom).inset(-18)
        }
        
        searchField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
            make.top.equalTo(nameTextField.snp.bottom).inset(-24)
        }
        
        searchFieldButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        
        searchResultsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom).inset(-24)
            make.bottom.equalTo(createButton.snp.top).inset(-10)
        }
        
        createButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(64)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(40)
        }
        
    }
    
    func configureTextFields() {
        nameTextField.delegate = self
        searchField.delegate = self
        
        let separateView = UIView()
        separateView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        let rightViewStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [searchFieldButton, separateView])
            return stack
        }()
        searchField.rightView = rightViewStack
    }
}

// MARK: - TextFields Delegate

extension CreatePlaylistViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == searchField {
            fetchSearchResults(searchText: textField.text!)
        }
        
        textField.resignFirstResponder()
        textField.endEditing(true)
        
        return true
    }
}

// MARK: - TableView Delegate

extension CreatePlaylistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            searchResultsViewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - TableView DataSource

extension CreatePlaylistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreatePlaylistTableViewCell.reuseId, for: indexPath) as? CreatePlaylistTableViewCell else {
            return UITableViewCell()
        }
        cell.fill(viewModel: searchResultsViewModels[indexPath.row])
        return cell
    }
}

// MARK: - Network Request Methods

extension CreatePlaylistViewController {
    
    func fetchSearchResults(searchText: String) {
        
        searchResultsViewModels = []
        
        let group = DispatchGroup()
        group.enter()
        NetworkManager().fetchFromSearchRequest(requestText: searchText, resultsCount: 1000) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(SearchResultModel.self, from: data)
                    for result in results.feeds {
                        self?.searchResultsViewModels.append(PlaylistTableViewModel(imageURLString: result.image, listName: result.title, authorName: result.author, duration: "\(result.episodeCount)", action: {}))
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
        self.searchResultsTableView.reloadData()
    }
}

extension CreatePlaylistViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
// В Этом методе мы получаем доступ к фото, когда пользователь его выбрал или сделал
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }}
