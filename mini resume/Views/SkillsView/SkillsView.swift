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
    
    var array = ["MVI/MVVM", "Kotlin Coroutines", "Room", "OkHttp", "DataStore", "WorkManager", "custom view", "DataStore", "ООП и SOLID"]
    
    private let itemCellSize: CGSize = CGSize(
        width: 100,
        height: 50
    )
    
    
    
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
    
    private let collectionView: UICollectionView = {
            let layout = CustomViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = CGSize(width: 100, height: 44)
            layout.minimumLineSpacing = 12
            
            let collection = UICollectionView(
                frame: .zero,
                collectionViewLayout: layout
            )
            collection.register(CellForCollection.self, forCellWithReuseIdentifier: CellForCollection.identifier)
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupElements()
        setupConstraints()
        setupCollection()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        addSubview(headerLabel)
        addSubview(changeIcon)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: changeIcon.leadingAnchor, constant: -8),
            
            changeIcon.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            changeIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: changeIcon.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - extension - UICollectionViewDataSource

extension SkillsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellForCollection.identifier,
            for: indexPath
        ) as! CellForCollection
        let model = array[indexPath.row]
        myCell.setup(text: model)
        return myCell
    }
    
    
}

//MARK: - extension - UICollectionViewDelegateFlowLayout

    
    
    extension SkillsView: UICollectionViewDelegateFlowLayout {
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat{
            return 12
        }
    }
