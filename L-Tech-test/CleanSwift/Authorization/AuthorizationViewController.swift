//
//  AuthorizationViewController.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 20.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AuthorizationDisplayLogic: AnyObject {
    
    func showUser(viewModel: Authorization.fetchUser.ViewModel)
    func showPhoneMask(viewModel: Authorization.getMaskNumber.ViewModel)
    func showErrorMaskNumberAlert(viewModel:Authorization.getMaskNumber.ViewModel)
    func showErrorCheckUserAlert(viewModel:Authorization.checkUser.ViewModel)
    func readyToMove()
}

class AuthorizationViewController: UIViewController, AuthorizationDisplayLogic {

    
    var interactor: AuthorizationBusinessLogic?
    var router: (NSObjectProtocol & AuthorizationRoutingLogic & AuthorizationDataPassing)?
    
    var maskNumber: MaskNumberModel?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        return scrollView
    }()
    
    var appleLogo: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "appleLogo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let numberLabel = UILabel(text: "Введите номер телефона")
    let passwordLabel = UILabel(text: "Введите пароль")
    let numberTF = UITextField(placeholder: "Номер телефона", isPassword: false)
    let passwordTF = UITextField(placeholder: "Пароль", isPassword: true)
    let loginButton = UIButton(title: "Авторизация")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupUI()
        numberTF.delegate = self
        numberTF.keyboardType = .numberPad
        AuthorizationConfigurator.shared.configure(with: self)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        interactor?.startSettings()
        
    }
    

    func showUser(viewModel: Authorization.fetchUser.ViewModel) {
        
        DispatchQueue.main.async {[weak self] in
            self?.maskNumber = viewModel.maskNumberModel
            self?.numberTF.text = viewModel.number
            self?.passwordTF.text = viewModel.password
            self?.numberTF.placeholder = viewModel.maskNumber
        }
    }
    
    func showPhoneMask(viewModel: Authorization.getMaskNumber.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.maskNumber = viewModel.maskNumberModel
            self?.numberTF.placeholder = viewModel.maskNumberModel.phoneMask
        }
    }
    
    
    func showErrorMaskNumberAlert(viewModel: Authorization.getMaskNumber.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController.showAlert(title: "", message: viewModel.error)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func loginButtonTapped () {
        let textFields = [numberTF, passwordTF]
        let placeholders = [maskNumber!.phoneMask, "Пароль"]
        
        guard let number = numberTF.text, number != "",
              let password = passwordTF.text, password != ""  else {
            
            for (textField, placeholder)  in zip(textFields, placeholders) {
                if textField.text == "" || textField.text == nil {
                    textField.fillTextField(placeholder: placeholder)
                }
            }
            return
        }
        let requestToCheckUser = Authorization.checkUser.Request(number: number, password: password, maskNumber: maskNumber ?? MaskNumberModel(phoneMask: ""))
        
        interactor?.checkUser(request: requestToCheckUser)
        loginButton.isHidden = true
    }
    
    func showErrorCheckUserAlert(viewModel: Authorization.checkUser.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController.showAlert(title: "", message: viewModel.error)
            self?.present(alert, animated: true, completion: nil)
            self?.loginButton.isHidden = false
        }
    }
    
    func readyToMove() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.routeToMainScreen()
            self?.loginButton.isHidden = false
        }
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

extension AuthorizationViewController {
    
    private func setupUI() {
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
        
        let emailStack = UIStackView(firstView: numberLabel, secondView: numberTF, spacing: 10)
        let passwordStack = UIStackView(firstView: passwordLabel, secondView: passwordTF, spacing: 10)
        let generalStack = UIStackView(firstView: emailStack, secondView: passwordStack, spacing: 30)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(appleLogo)
        scrollView.addSubview(generalStack)
        view.addSubview(loginButton)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            generalStack.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            generalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            appleLogo.bottomAnchor.constraint(equalTo: generalStack.topAnchor, constant: -50),
            appleLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            appleLogo.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.25),
            appleLogo.heightAnchor.constraint(equalTo: appleLogo.widthAnchor),
            
            loginButton.topAnchor.constraint(equalTo: generalStack.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

//MARK: - UITextFieldDelegate 

extension AuthorizationViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullstring = (textField.text ?? "") + string
        textField.text = format(phonenumber: fullstring, maskNumber: maskNumber, shouldRemoveLastDigit: range.length == 1, range: range)
        return false
    }

}



//MARK: - work with keyBoard appearence

extension AuthorizationViewController {
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbFrameSize.height, right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    @objc func kbDidHide() {
        UIView.animate(withDuration: 0) {
            
            self.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


