//
//  AboutMeView.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

/// view с описание о человеке
class AboutMeView: UIView {
    
    //MARK: - Properties
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let headerText = "О себе"
    }
    
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.headerText
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Experienced software engineer skilled in developing scalable and maintainable systems"
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupElements()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        addSubview(headerLabel)
        addSubview(descriptionLabel)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
            
        ])
    }
}
