//
//  Cell.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 21.10.2021.
//

import UIKit


protocol CellModelRepresentable {
    var cellModel: CellIdentifiable? { get set }
}

class Celll: UITableViewCell, CellModelRepresentable {
    
    static let identifier = "Celll"
    var cellTag: Int?
    var imageCache = NSCache<NSString, UIImage>()
    var cellModel: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews () {
        guard let cellModel = cellModel as? ModelCellViewModel else { return }
        DispatchQueue.global().async {
            if let imageData = ImageManager.shared.fetchImageData(from: cellModel.imageString) {
                DispatchQueue.main.async {
                    if let cachedImage = self.imageCache.object(forKey: cellModel.imageString! as NSString) {
                        self.imageViewCell.image = cachedImage
                    } else {
                        guard let image = UIImage(data: imageData) else {
                            self.imageViewCell.image = UIImage(named: "noImage")
                            return
                        }
                        self.imageViewCell.image = image
                        self.imageCache.setObject(image, forKey: cellModel.imageString! as NSString)
                    }
                }
            }
        }
        self.titleLabel.text = cellModel.title
        self.detTextLabel.text = cellModel.text
            
            guard let date = cellModel.date else { return }
            self.dateLabel.text = getStringFromDate(inputDate: date)
        
    }
    
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 24)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var detTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = .left
        textLabel.textColor = .black
        textLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 16)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.5
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .left
        dateLabel.textColor = .black
        dateLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 16)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.5
        dateLabel.numberOfLines = 1
        dateLabel.lineBreakMode = .byWordWrapping
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    var imageViewCell: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.addSubview(titleLabel)
        contentView.addSubview(detTextLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imageViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageViewCell.widthAnchor.constraint(equalToConstant: 80),
            imageViewCell.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            detTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            detTextLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: detTextLabel.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func createCell(tableView: UITableView, title: String, detText: String, date: String, imageURL: String, indexPath: IndexPath) {
//        self.titleLabel.text = title
//        self.detTextLabel.text = detText
//        self.dateLabel.text = date
//
//        DispatchQueue.global().async {
//            guard let url = URL(string: imageURL), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else {
//                return
//            }
//            DispatchQueue.main.async {
//                guard let cell = tableView.cellForRow(at: indexPath) as? Celll else { return }
//                cell.imageViewCell.image = image
//            }
//        }
//    }
}



//import UIKit
//
//
//
//
//class Celll: UITableViewCell {
//
//
//    static let identifier = "Celll"
//
//    lazy var titleLabel: UILabel = {
//        let titleLabel = UILabel()
//        titleLabel.textAlignment = .left
//        titleLabel.textColor = .black
//        titleLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 24)
//        titleLabel.adjustsFontSizeToFitWidth = true
//        titleLabel.minimumScaleFactor = 0.5
//        titleLabel.numberOfLines = 0
//        titleLabel.lineBreakMode = .byWordWrapping
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        return titleLabel
//    }()
//
//    lazy var detTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.textAlignment = .left
//        textLabel.textColor = .black
//        textLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 16)
//        textLabel.adjustsFontSizeToFitWidth = true
//        textLabel.minimumScaleFactor = 0.5
//        textLabel.numberOfLines = 0
//        textLabel.lineBreakMode = .byWordWrapping
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        return textLabel
//    }()
//
//    lazy var dateLabel: UILabel = {
//        let dateLabel = UILabel()
//        dateLabel.textAlignment = .left
//        dateLabel.textColor = .black
//        dateLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 16)
//        dateLabel.adjustsFontSizeToFitWidth = true
//        dateLabel.minimumScaleFactor = 0.5
//        dateLabel.numberOfLines = 0
//        dateLabel.lineBreakMode = .byWordWrapping
//        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        return dateLabel
//    }()
//
//    var imageViewCell: UIImageView = {
//        var imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(detTextLabel)
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(imageViewCell)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        NSLayoutConstraint.activate([
//            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            imageViewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
//            imageViewCell.heightAnchor.constraint(equalTo: imageViewCell.widthAnchor),
//            imageViewCell.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
//        ])
//
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: imageViewCell.topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 16),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        ])
//
//        NSLayoutConstraint.activate([
//            detTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            detTextLabel.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 16),
//            detTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        ])
//
//        NSLayoutConstraint.activate([
//            dateLabel.topAnchor.constraint(equalTo: detTextLabel.bottomAnchor, constant: 10),
//            dateLabel.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 16),
//            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
//        ])
//
//
//    }
//
//    func createCell(tableView: UITableView, title: String, detText: String, date: String, imageURL: String, indexPath: IndexPath) {
//        self.titleLabel.text = title
//        self.detTextLabel.text = detText
//        self.dateLabel.text = date
//
//        DispatchQueue.global().async {
//            guard let url = URL(string: imageURL), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else {
//                return
//            }
//            DispatchQueue.main.async {
//                guard let cell = tableView.cellForRow(at: indexPath) as? Celll else { return }
//                cell.imageViewCell.image = image
//            }
//        }
//    }
//}
