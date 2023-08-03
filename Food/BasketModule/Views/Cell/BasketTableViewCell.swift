//
//  BasketTableViewCell.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import UIKit.UITableViewCell
import SDWebImage

final class BasketTableViewCell: UITableViewCell {
    
    static let identifier = "BasketTableViewCell"
    
    let incrementDecrementButton = IncrementDecrementButton()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Resources.Colors.productImageViewBackgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.defaultBlackColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceWeightLabel)
        contentView.addSubview(incrementDecrementButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUIWithData(_ dish: DishRealm) {
        let url = URL(string: "\(dish.imageURL)")
        
        productImageView.sd_setImage(with: url, completed: nil)
        productNameLabel.text = dish.name
        priceWeightLabel.text = "\(dish.price) ₽ · \(dish.weight)г"
    }
}

private extension BasketTableViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 62),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            productNameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productNameLabel.widthAnchor.constraint(equalToConstant: 119),
            
            priceWeightLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 3),
            priceWeightLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceWeightLabel.widthAnchor.constraint(equalToConstant: 119),
            
            incrementDecrementButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            incrementDecrementButton.widthAnchor.constraint(equalToConstant: 99),
            incrementDecrementButton.heightAnchor.constraint(equalToConstant: 32),
            incrementDecrementButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
