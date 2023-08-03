//
//  IncrementDecrementButton.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import UIKit.UIView

protocol IncrementDecrementButtonDelegate: AnyObject {
    func didTapMinusButton(_ incrementDecrementButton: IncrementDecrementButton, tag: Int)
    func didTapPlusButton(_ incrementDecrementButton: IncrementDecrementButton, tag: Int)
}

final class IncrementDecrementButton: UIView {
    
    weak var delegate: IncrementDecrementButtonDelegate?
    
    private let minusButton = UIButton()
    private let quantityLabel = UILabel()
    private let plusButton = UIButton()
  
    var count = 1 {
        didSet {
            quantityLabel.text = "\(count)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Resources.Colors.incrementDecrementButtonColor
        addSubview(minusButton)
        addSubview(quantityLabel)
        addSubview(plusButton)
        configure()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.backgroundColor = .clear
        minusButton.setImage(Resources.Images.IncrementDecrementButton.minus, for: .normal)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.textColor = Resources.Colors.geoInfoDateColor
        quantityLabel.text = "\(count)"
        quantityLabel.textAlignment = .center
        quantityLabel.font = UIFont.systemFont(ofSize: 14)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.backgroundColor = .clear
        plusButton.setImage(Resources.Images.IncrementDecrementButton.plus, for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc func minusButtonTapped() {
        delegate?.didTapMinusButton(self, tag: tag)
    }
    
    @objc func plusButtonTapped() {
        delegate?.didTapPlusButton(self, tag: tag)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            minusButton.heightAnchor.constraint(equalToConstant: 24),
            minusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 16),
            quantityLabel.heightAnchor.constraint(equalToConstant: 15),
            quantityLabel.widthAnchor.constraint(equalToConstant: 7),
            
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            plusButton.heightAnchor.constraint(equalToConstant: 24),
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
