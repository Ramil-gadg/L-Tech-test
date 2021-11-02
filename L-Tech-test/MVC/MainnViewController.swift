////
////  MainnViewController.swift
////  L-Tech-test
////
////  Created by Рамил Гаджиев on 20.10.2021.
////
//
//import UIKit
//
//
//
//class MainnViewController: UIViewController {
//    
//    var timer = Timer()
//    var models = [MyDetailScreenModel]() {
//        didSet {
//            DispatchQueue.main.async {[weak self] in
//                self?.ttableView.reloadData()
//            }
//        }
//    }
//    
//    
//    var activityIndicator: UIActivityIndicatorView = {
//        var indicator = UIActivityIndicatorView()
//        indicator.startAnimating()
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        return indicator
//    }()
//    
//    var segmentedControl: UISegmentedControl = {
//        var segmentedControl = UISegmentedControl(items: ["Сортировка сервера", "Сортировка по дате"])
//        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControl.backgroundColor = .white
//        let font: [NSAttributedString.Key : UIFont?] = [NSAttributedString.Key.font : UIFont(name: "KohinoorBangla-Regular", size: 16)]
//        segmentedControl.setTitleTextAttributes(font as [NSAttributedString.Key : Any], for: .normal)
//        segmentedControl.layer.cornerRadius = 10
//        segmentedControl.layer.masksToBounds = true
//        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
//        return segmentedControl
//    }()
//    
//    var ttableView: UITableView = {
//        var tableView = UITableView()
//        tableView.register(Celll.self, forCellReuseIdentifier: Celll.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//        
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        ttableView.delegate = self
//        ttableView.dataSource = self
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
//        setupUI()
//        
//    }
//    
//    @objc func timerAction() {
//        NetworkManager.shared.getDetailInfo {[weak self] models, error in
//            guard error == nil else {
//                return
//            }
//                guard let models = models else {return}
//            var myModels = [MyDetailScreenModel]()
//            for model in models {
//                let myModel = MyDetailScreenModel(detailScreenModel: model)
//                myModels.append(myModel)
//            }
//            var sortedMyModel = [MyDetailScreenModel]()
//            DispatchQueue.main.async {
//                switch self?.segmentedControl.selectedSegmentIndex {
//                case 0: sortedMyModel = myModels.sorted{$0.sort! < $1.sort!}
//                case 1: sortedMyModel = myModels.sorted{$0.date! > $1.date!}
//                default: sortedMyModel = myModels
//                }
//                self?.models = sortedMyModel
//            }
//        }
//    }
//    
//    @objc func logOutTapped() {
//        navigationController?.popToRootViewController(animated: true)
//    }
//    
//    @objc func reloadData() {
//        NetworkManager.shared.getDetailInfo {[weak self] models, error in
//            guard error == nil else {
//                return
//            }
//                guard let models = models else {return}
//            var myModels = [MyDetailScreenModel]()
//            for model in models {
//                let myModel = MyDetailScreenModel(detailScreenModel: model)
//                myModels.append(myModel)
//            }
//                var sortedMyModel = [MyDetailScreenModel]()
//                DispatchQueue.main.async {
//                    switch self?.segmentedControl.selectedSegmentIndex {
//                    case 0: sortedMyModel = myModels.sorted{$0.sort! < $1.sort!}
//                    case 1: sortedMyModel = myModels.sorted{$0.date! > $1.date!}
//                    default: sortedMyModel = myModels
//                    }
//                    self?.models = sortedMyModel
//                }
//        }
//    }
//    
//    @objc func segmentedControlValueChanged (_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            models.sort{$0.sort! < $1.sort!}
//            ttableView.reloadData()
//        case 1:
//            models.sort{$0.date! > $1.date!}
//            ttableView.reloadData()
//        default:
//            models.sort{$0.sort! > $1.sort!}
//            ttableView.reloadData()
//        }
//    }
//    
//    
//    override func viewDidLayoutSubviews() {
//        ttableView.reloadData()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        timer.invalidate()
//    }
//}
//
//extension MainnViewController {
//    
//    private func setupUI() {
//        view.addSubview(ttableView)
//        view.addSubview(segmentedControl)
//        view.addSubview(activityIndicator)
//        view.backgroundColor = .white
//        navigationController?.isNavigationBarHidden = false
//        ttableView.separatorInset.bottom = 5
//        
//        
//        
//        
//        NSLayoutConstraint.activate([
//            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            segmentedControl.heightAnchor.constraint(equalToConstant: 50),
//
//
//            ttableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
//            ttableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            ttableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            ttableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.heightAnchor.constraint(equalToConstant: 20),
//            activityIndicator.widthAnchor.constraint(equalToConstant: 20)
//        ])
//    }
//}
//
//
////MARK: - TableViewDelegate and TableViewDataSource
//
//extension MainnViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        models.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Celll.identifier, for: indexPath) as? Celll else {
//            return UITableViewCell()}
//        let currentModel = models[indexPath.row]
//        let stringDate = getStringFromDate(inputDate: currentModel.date!)
//        guard let currentTitle = currentModel.title,
//        let currentDetail = currentModel.text,
//        let currentImageString = currentModel.image else {
//            return UITableViewCell() }
//        
//        let vcccurrentImageString = "http://dev-exam.l-tech.ru\(currentImageString)"
//        cell.imageViewCell.image = UIImage(named: "noImage")
////        cell.createCell(tableView: ttableView, title: currentTitle, detText: currentDetail, date: stringDate, imageURL: vcccurrentImageString, indexPath: indexPath)
//        activityIndicator.isHidden = true
//        activityIndicator.stopAnimating()
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = models[indexPath.row]
//        let detailVC = DetailViewController()
//        detailVC.model = model
//        detailVC.title = model.title
//        navigationController?.pushViewController(detailVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}
//
//
//
