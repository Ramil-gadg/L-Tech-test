////
////  DetailViewController.swift
////  L-Tech-test
////
////  Created by Рамил Гаджиев on 24.10.2021.
////
//
//import UIKit
//
//class DetailViewController: UIViewController {
//
//    var model: MyDetailScreenModel? {
//        didSet {
//            titleLabel.text = model?.title
//            textLabel.text = model?.text
//            image.image = UIImage(named: "noImage")
//            DispatchQueue.global().async { [weak self] in
//                guard let imageString = self?.model?.image,
//                      let url = URL(string: "http://dev-exam.l-tech.ru\(imageString)"),
//                      let data = try? Data(contentsOf: url) else { return }
//                DispatchQueue.main.async {
//                    self?.image.image = UIImage(data: data)
//                }
//            }
//        }
//    }
//    
//    var image: UIImageView = {
//        var imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//
//    var titleLabel = UILabel(text: "title", size: 22)
//    var textLabel = UILabel(text: "text")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//
//    }
//}
//
//extension DetailViewController {
//
//    private func setupUI() {
//
//        view.backgroundColor = .white
//        view.addSubview(image)
//        view.addSubview(titleLabel)
//        view.addSubview(textLabel)
//
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
//            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
//            image.heightAnchor.constraint(equalTo: image.widthAnchor),
//
//
//            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//
//            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
//            textLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            textLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
//
//        ])
//    }
//}
