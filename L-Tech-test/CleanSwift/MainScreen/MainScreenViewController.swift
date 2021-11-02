//
//  MainScreenViewController.swift
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

protocol MainScreenDisplayLogic: AnyObject {
    func displayModels(viewModel: MainScreen.ShowModels.ViewModel)
}

class MainScreenViewController: UIViewController, MainScreenDisplayLogic {
    

    var interactor: MainScreenBusinessLogic?
    var router: (NSObjectProtocol & MainScreenRoutingLogic & MainScreenDataPassing)?
    var timer = Timer()
    var models = [MyDetailScreenModel]()
    private var rows: [CellIdentifiable] = [] 
    
    
    var segmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl(items: ["Сортировка сервера", "Сортировка по дате"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .white
        let font: [NSAttributedString.Key : UIFont?] = [NSAttributedString.Key.font : UIFont(name: "KohinoorBangla-Regular", size: 16)]
        segmentedControl.setTitleTextAttributes(font as [NSAttributedString.Key : Any], for: .normal)
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.layer.masksToBounds = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    var ttableView: UITableView = {
        var tableView = UITableView()
        tableView.register(Celll.self, forCellReuseIdentifier: Celll.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ttableView.delegate = self
        ttableView.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        setupUI()
        interactor?.provideMainScreen()
    }
    
    func displayModels(viewModel: MainScreen.ShowModels.ViewModel) {
        self.rows = viewModel.rows
        DispatchQueue.main.async { [weak self] in
            self?.ttableView.reloadData()
        }
    }
    
    @objc func timerAction() {
        interactor?.reloadTableView()
        
    }
    
    @objc func logOutTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func reloadData() {
        interactor?.reloadTableView()
        
    }
    
    @objc func segmentedControlValueChanged (_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            interactor?.sortByServer()
        case 1:
            interactor?.sortByDate()
        default:
            interactor?.sortByServer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()
        let router = MainScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}


//MARK: - Setup UI
extension MainScreenViewController {
    
    private func setupUI() {
        view.addSubview(ttableView)
        view.addSubview(segmentedControl)
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50),
            
            
            ttableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            ttableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ttableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ttableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - TableViewDelegate and TableViewDataSource

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath) as? Celll else {
            return UITableViewCell()}
        cell.cellModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.router?.routeToDetailScreen()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}