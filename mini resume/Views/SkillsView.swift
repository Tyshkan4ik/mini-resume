//
//  SkillsView.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

/// view с Навыками человека
class SkillsView: UIView {
    
    //MARK: - Properties
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let headerText = "Мои навыки"
    }
    
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.headerText
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeIcon: UIImageView = {
        let image = UIImage(named: "changeIcon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(changeIcon)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: changeIcon.leadingAnchor, constant: -8),
            
            changeIcon.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            changeIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
