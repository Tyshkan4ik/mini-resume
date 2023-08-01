//
//  SkillsView.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

protocol SkillsViewDelegate: AnyObject {
    func skillsViewDidOpenNewSkill(_ view: SkillsView)
}

/// view с Навыками человека
class SkillsView: UIView {
    weak var delegate: SkillsViewDelegate?
    
    //MARK: - Properties
    /// Константы используемые в данном классе
    private enum Constants {
        static let headerText = "Мои навыки"
    }
    
    private var isEditing: Bool = false
    
    private var array: [SkillsCellModel] = []
    
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.headerText
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editButton: UIButton = {
        let image = UIImage(named: "changeIcon")
        let button = UIButton()
        button.imageView?.tintColor = UIColor(hex: "313131")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = CustomViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 12
        
        let collection = CustomCollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collection.register(SkillsCell.self, forCellWithReuseIdentifier: SkillsCell.identifier)
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
        editButton.addTarget(self, action: #selector(tapToEditButton), for: .touchUpInside)
        
        CoreDataManager.shared.getMessages { [weak self] skills in
            self?.array = skills.map {
                SkillsCellModel(title: $0.title, isEditing: false)
            }
            self?.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        addSubview(headerLabel)
        addSubview(editButton)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),
            
            editButton.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc
    private func tapToEditButton() {
        isEditing.toggle()
        
        let image = UIImage(
            named: isEditing ? "applyIcon" : "changeIcon"
        )
        editButton.setImage(image, for: .normal)
        
        array = array.map {
            SkillsCellModel(title: $0.title, isEditing: isEditing)
        }
        
        if isEditing {
            array.append(SkillsCellModel(title: "+", isEditing: false, id: 1))
        } else {
            array.removeLast()
        }
        
        collectionView.reloadData()
    }
    
    func addNew(_ skill: String) {
        CoreDataManager.shared.save(skill: skill)
        
        if isEditing {
            array.insert(
                SkillsCellModel(title: skill, isEditing: true),
                at: array.count - 1
            )
            collectionView.reloadData()
        }
    }
}

//MARK: - extension - UICollectionViewDataSource
extension SkillsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SkillsCell.identifier,
            for: indexPath
        ) as! SkillsCell
        let model = array[indexPath.row]
        myCell.indexPath = indexPath
        myCell.setup(model: model)
        myCell.delegate = self
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = array[indexPath.row]
        
        if model.id == 1 {
            delegate?.skillsViewDidOpenNewSkill(self)
        }
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

extension SkillsView: SkillsCellDelegate {
    func skillsCell(_ cell: SkillsCell, didRemoveAt indexPath: IndexPath) {
        let skill = array.remove(at: indexPath.row)
        CoreDataManager.shared.delete(skill: skill.title)
        collectionView.reloadData()
    }
}

