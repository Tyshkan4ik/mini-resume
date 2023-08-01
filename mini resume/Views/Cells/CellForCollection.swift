//
//  CellForCollection.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

/// Ячейка для коллекции
class CellForCollection: UICollectionViewCell {
    
    private enum Constants {
        static let myImageCornerRadius: CGFloat = 10
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var label: UILabel = {
        let label = UILabel()
         label.textColor = UIColor(hex: "313131")
         label.font = UIFont.boldSystemFont(ofSize: 14)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = Constants.myImageCornerRadius
        backgroundColor = .systemIndigo
       setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Methods
    
    func setupElements() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -12),
        ])
    }
    
    func setup(text: String) {
        label.text = text
    }
}

