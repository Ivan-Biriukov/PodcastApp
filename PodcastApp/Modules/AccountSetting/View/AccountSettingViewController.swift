//
//  AccountSettingViewController.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 28.09.2023.
//

import UIKit
import SnapKit

final class AccountSettingViewController: BaseViewController {
    
    // MARK: - Properties
    private let presenter: AccountSettingPresenterProtocol
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var recipeImageLocalPath : String = ""
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "backImage"), for: .normal)
        button.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileLabel: UILabel = {
        return createLabel(
            text: "Profile",
            font: .systemFont(ofSize: 18, weight: .bold),
            textColor: .black,
            alignment: .left)
    }()
    
    private lazy var photoView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var editPhotoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "editPhotoImage"), for: .normal)
        button.addTarget(self, action: #selector(editPhotoPressed), for: .touchUpInside)
        return button
    }()
    
    private let photoPickerView : UIImagePickerController = {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        return piker
    }()
    
    private lazy var firstNameView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var firstNameLabel: UILabel = {
        return createLabel(
            text: "First Name",
            font: .systemFont(ofSize: 14),
            textColor: .init(rgb: 0x78828A),
            alignment: .left)
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.placeholder = "Enter First Name"
        textField.minimumFontSize = 12
        textField.layer.borderColor = UIColor(rgb: 0x2882F1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 24
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .continue
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var lastNameView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var lastNameLabel: UILabel = {
        return createLabel(
            text: "Last Name",
            font: .systemFont(ofSize: 14),
            textColor: .init(rgb: 0x78828A),
            alignment: .left)
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.placeholder = "Enter Last Name"
        textField.minimumFontSize = 12
        textField.layer.borderColor = UIColor(rgb: 0x2882F1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 24
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .continue
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var emailView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        return createLabel(
            text: "E-mail",
            font: .systemFont(ofSize: 14),
            textColor: .init(rgb: 0x78828A),
            alignment: .left)
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.placeholder = "Enter e-mail"
        textField.minimumFontSize = 12
        textField.layer.borderColor = UIColor(rgb: 0x2882F1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 24
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .continue
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var dateOfBirthView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var dateOfBirthLabel: UILabel = {
        return createLabel(
            text: "Date of Birth",
            font: .systemFont(ofSize: 14),
            textColor: .init(rgb: 0x78828A),
            alignment: .left)
    }()
    
    private lazy var dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.placeholder = "Choose your date of birth"
        textField.minimumFontSize = 12
        textField.layer.borderColor = UIColor(rgb: 0x2882F1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 24
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendarIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var genderView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var genderLabel: UILabel = {
        return createLabel(
            text: "Gender",
            font: .systemFont(ofSize: 14),
            textColor: .init(rgb: 0x78828A),
            alignment: .left)
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Male", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0x2882F1).cgColor
        button.layer.cornerRadius = 24
        let normalImage = UIImage(named: "unselectedCheckmark")
        button.setImage(normalImage, for: .normal)
        let selectedImage = UIImage(named: "selectedCheckmark")
        button.setImage(selectedImage, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(malePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Female", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0x2882F1).cgColor
        button.layer.cornerRadius = 24
        let normalImage = UIImage(named: "unselectedCheckmark")
        button.setImage(normalImage, for: .normal)
        let selectedImage = UIImage(named: "selectedCheckmark")
        button.setImage(selectedImage, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(femalePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var genderStackView: UIStackView = {
        createStackView(
            for: maleButton, femaleButton,
            axis: .horizontal,
            spacing: 16.0,
            distribution: .fillEqually,
            alignment: .fill)
    }()
    
    private lazy var settingsStackView: UIStackView = {
        createStackView(
            for: firstNameView, lastNameView, emailView, dateOfBirthView, genderView,
            axis: .vertical,
            spacing: 16.0,
            distribution: .fill,
            alignment: .center)
    }()
    
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.init(rgb: 0x9CA4AB), for: .normal)
        button.backgroundColor = .init(rgb: 0xECF1F6)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(saveChangesPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.contentSize = contentSize
        scroll.frame = view.bounds
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .white
        return view
    }()
        
    
    // MARK: - Init
    init(presenter: AccountSettingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKeyBoardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        setupPhotoPicker()
        setupTextFields()
        registerForKeyBoardNotifications()
        setupDatePicker()
    }
    
}

extension AccountSettingViewController: AccountSettingViewInput {
    
}

// MARK: - Extensions
private extension AccountSettingViewController {
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        photoView.addSubview(photoImage)
        photoView.addSubview(editPhotoButton)
        
        firstNameView.addSubview(firstNameLabel)
        firstNameView.addSubview(firstNameTextField)
        
        lastNameView.addSubview(lastNameLabel)
        lastNameView.addSubview(lastNameTextField)
        
        emailView.addSubview(emailLabel)
        emailView.addSubview(emailTextField)
        
        dateOfBirthView.addSubview(dateOfBirthLabel)
        dateOfBirthView.addSubview(dateOfBirthTextField)
        rightView.addSubview(rightImageView)
        dateOfBirthTextField.addSubview(rightView)
        
        genderView.addSubview(genderLabel)
        genderView.addSubview(genderStackView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(profileLabel)
        contentView.addSubview(photoView)
        contentView.addSubview(settingsStackView)
        contentView.addSubview(saveChangesButton)
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).inset(16)
            make.leading.equalTo(scrollView.snp.leading).inset(24)
            make.trailing.equalTo(scrollView.snp.trailing).inset(24)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(26)
            make.width.equalTo(58)
        }
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.centerX.equalTo(contentView.snp.centerX).inset(5)
            make.width.equalTo(105)
            make.height.equalTo(100)
        }
        
        photoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(68)
            make.leading.equalToSuperview().offset(73)
            make.width.height.equalTo(32)
        }
        
        settingsStackView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(view.frame.width - 48)
        }
        
        firstNameView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(82)
        }
        
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        lastNameView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(82)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        emailView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(82)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        dateOfBirthView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(82)
        }
        
        dateOfBirthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        dateOfBirthTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { make in
            make.trailing.equalTo(dateOfBirthTextField.snp.trailing).inset(12)
            make.centerY.equalTo(dateOfBirthTextField.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        genderView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(78)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(900)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(48)
            make.bottom.equalTo(contentView.snp.bottom).offset(8)
        }
    }
}

// MARK: - Target Actions
extension AccountSettingViewController {
    
    @objc func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editPhotoPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.present(self.photoPickerView, animated: true)
        }
    }
    
    @objc func malePressed() {
        print("Male Pressed")
        
        maleButton.isSelected = !maleButton.isSelected
        femaleButton.isSelected = false
    }
    
    @objc func femalePressed() {
        print("Female Pressed")
        
        femaleButton.isSelected = !femaleButton.isSelected
        maleButton.isSelected = false
    }
    
    @objc func saveChangesPressed() {
        print("Save Changes Pressed")
    }
}

// MARK: - ImagePickerControllerDelegate
extension AccountSettingViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func setupPhotoPicker() {
        photoPickerView.delegate = self
        photoPickerView.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.recipeImageLocalPath = save(image: choosenImage)!
        self.photoImage.image = choosenImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AccountSettingViewController {
    
    private func save(image: UIImage) -> String? {
        let fileName = "FileName"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
}

// MARK: - UITextFieldDelegate
extension AccountSettingViewController: UITextFieldDelegate {
    
    func setupTextFields() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    func registerForKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyBoardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbWillShow(_ notification: Notification, sender: UITextField) {
        let userInfo = notification.userInfo
        let keyBoardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyBoardFrameSize.height / 2)
    }
    
    @objc private func kbWillHide(sender: UITextField) {
        scrollView.contentOffset = CGPoint.zero
    }
}

// MARK: - DatePicker
extension AccountSettingViewController {
    
    private func setupDatePicker() {
        dateOfBirthTextField.datePicker(target: self,
                             doneAction: #selector(doneAction),
                             cancelAction: #selector(cancelAction),
                             datePickerMode: .date)
    }
    
    @objc func cancelAction() {
        dateOfBirthTextField.resignFirstResponder()
    }
    
    @objc func doneAction() {
        if let datePickerView = self.dateOfBirthTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            dateOfBirthTextField.text = dateString
            dateOfBirthTextField.resignFirstResponder()
        }
    }
}

extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}
