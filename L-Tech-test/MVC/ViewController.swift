////
////  ViewController.swift
////  L-Tech-test
////
////  Created by Рамил Гаджиев on 18.10.2021.
////
//
//import UIKit
//
//
//
//class ViewController: UIViewController, UITextFieldDelegate {
//
//
//    var maskNumber: MaskNumberModel?
//   // var clearNumber: String?
//
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
//        return scrollView
//    }()
//
//    var appleLogo: UIImageView = {
//        var imageView = UIImageView()
//        imageView.image = UIImage(named: "appleLogo")
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    let numberLabel = UILabel(text: "Введите номер телефона")
//    let passwordLabel = UILabel(text: "Введите пароль")
//    let numberTF = UITextField(placeholder: "Номер телефона", isPassword: false)
//    let passwordTF = UITextField(placeholder: "Пароль", isPassword: true)
//    let loginButton = UIButton(title: "Авторизация")
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
//        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.hideKeyboardWhenTappedAround()
//        numberTF.delegate = self
//        //passwordTF.delegate = self
//        numberTF.keyboardType = .numberPad
//        setupUI()
//        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//
//        if let user = KeychainHelper.standard.read(service: "access-user", account: "test", type: KeyChainModel.self) {
//            self.maskNumber = user.maskNumber
//            self.numberTF.placeholder = maskNumber?.phoneMask
//            self.numberTF.text = user.number
//            self.passwordTF.text = user.password
//
//        } else {
//
//            NetworkManager.shared.getMaskNumber { maskNumber, error in
//                guard let maskNumber = maskNumber else {
//                    self.maskNumber = MaskNumberModel(phoneMask: "")
//                    let alert = UIAlertController.showAlert(title: "Ошибка", message: error ?? "неизвестная ошибка")
//                    self.present(alert, animated: true)
//                    return}
//                self.maskNumber = maskNumber
//                DispatchQueue.main.async { [weak self] in
//                    self?.numberTF.placeholder = maskNumber.phoneMask
//                }
//            }
//        }
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let fullstring = (textField.text ?? "") + string
//        textField.text = format(phonenumber: fullstring, maskNumber: maskNumber, shouldRemoveLastDigit: range.length == 1, shouldRemoveDigits: range.length > 1, range: range)
//        return false
//    }
//
//
//    @objc func loginButtonTapped () {
//        let textFields = [numberTF, passwordTF]
//        let placeholders = [maskNumber!.phoneMask, "Пароль"]
//
//        guard let number = numberTF.text, number != "",
//              let password = passwordTF.text, password != ""  else {
//
//            for (textField, placeholder)  in zip(textFields, placeholders) {
//                if textField.text == "" || textField.text == nil {
//                    textField.fillTextField(placeholder: placeholder)
//                }
//            }
//            return
//        }
//
//        let userNumber = numberTF.text!.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
//        let userPassword = password
//        let user = UserModel(phone: userNumber, password: userPassword)
//        NetworkManager.shared.auth(userModel: user) {[weak self] bool, error in
//            if bool {
//
//                NetworkManager.shared.getDetailInfo { [self] models, error in
//                        guard error == nil else {
//                            return
//                        }
//                        guard let models = models else {return}
//                        var myModels = [MyDetailScreenModel]()
//                        for model in models {
//                            let myModel = MyDetailScreenModel(detailScreenModel: model)
//                            myModels.append(myModel)
//                        }
//                    DispatchQueue.main.async { [weak self] in
//                        let mainVC = MainnViewController()
//                        mainVC.title = "Dev Exam"
//                        mainVC.models = myModels
//                        self?.navigationController?.pushViewController(mainVC, animated: true)
//                        let user = KeyChainModel(number: self?.numberTF.text, password: self?.passwordTF.text, maskNumber: self?.maskNumber)
//                        KeychainHelper.standard.save(user, service: "access-user", account: "test")
//                    }
//                }
//            } else {
//                DispatchQueue.main.async { [weak self] in
//                    let alert = UIAlertController.showAlert(title: "Ошибка", message: error ?? "неизвестная ошибка")
//                    self?.present(alert, animated: true)
//                }
//            }
//        }
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
//    }
//}
//
//extension ViewController {
//
//    private func setupUI() {
//        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
//
//        let emailStack = UIStackView(firstView: numberLabel, secondView: numberTF, spacing: 10)
//        let passwordStack = UIStackView(firstView: passwordLabel, secondView: passwordTF, spacing: 10)
//        let generalStack = UIStackView(firstView: emailStack, secondView: passwordStack, spacing: 30)
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        generalStack.translatesAutoresizingMaskIntoConstraints = false
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(appleLogo)
//        scrollView.addSubview(generalStack)
//        view.addSubview(loginButton)
//
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//            generalStack.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
//            generalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            generalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            generalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            appleLogo.bottomAnchor.constraint(equalTo: generalStack.topAnchor, constant: -50),
//            appleLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            appleLogo.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.25),
//            appleLogo.heightAnchor.constraint(equalTo: appleLogo.widthAnchor),
//
//            loginButton.topAnchor.constraint(equalTo: generalStack.bottomAnchor, constant: 40),
//            loginButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 50),
//            loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -50),
//            loginButton.heightAnchor.constraint(equalToConstant: 50)
//
//        ])
//    }
//}
//
//
////MARK: - work with keyBoard appearence
//
//extension ViewController {
//
//    @objc func kbDidShow(notification: Notification) {
//        guard let userInfo = notification.userInfo else {return}
//        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbFrameSize.height, right: 0.0)
//        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
//    }
//    @objc func kbDidHide() {
//        UIView.animate(withDuration: 0) {
//
//            self.scrollView.contentInset = UIEdgeInsets.zero
//        }
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
//
