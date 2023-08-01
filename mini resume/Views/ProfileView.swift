//
//  ProfileView.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

/// view с Профайлом человека
class ProfileView: UIView {
    
    //MARK: - Properties
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let headerText = "Профиль"
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.headerText
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarView: UIImageView = {
        let image = UIImage(named: "avatar2")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let namePeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "Троицкий Виталий Александрович"
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Junior iOS-разработчик, опыт более 1 года"
        label.textColor = UIColor(hex: "96959B")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewLocation: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackLocation: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Санкт-Петербург"
        label.textColor = UIColor(hex: "96959B")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private let locationIcon: UIImageView = {
        let image = UIImage(named: "locationIcon")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "F3F3F5")
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
        addSubview(avatarView)
        addSubview(namePeopleLabel)
        addSubview(shortDescriptionLabel)
        
        addSubview(stackLocation)
        stackLocation.addArrangedSubview(locationIcon)
        stackLocation.addArrangedSubview(cityLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 42),
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 120),
            avatarView.widthAnchor.constraint(equalToConstant: 120),
            
            namePeopleLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            namePeopleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            namePeopleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            shortDescriptionLabel.topAnchor.constraint(equalTo: namePeopleLabel.bottomAnchor, constant: 4),
            shortDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            shortDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stackLocation.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor),
            stackLocation.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            stackLocation.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            stackLocation.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -19),
            stackLocation.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
