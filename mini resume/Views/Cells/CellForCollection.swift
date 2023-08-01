//
//  CellForCollection.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit


protocol SkillsCellDelegate: AnyObject {
    func skillsCell(_ cell: SkillsCell, didRemoveAt indexPath: IndexPath)
}

/// Ячейка для коллекции
class SkillsCell: UICollectionViewCell {
    
    private enum Constants {
        static let myImageCornerRadius: CGFloat = 10
    }
    
    weak var delegate: SkillsCellDelegate?
    var indexPath: IndexPath?
    
    //MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "313131")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "crossIcon")
        button.setImage(image, for: .normal)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = Constants.myImageCornerRadius
        backgroundColor = UIColor(hex: "#F3F3F5")
        crossButton.addTarget(self, action: #selector(tapToCrossButton), for: .touchUpInside)
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    @objc
    private func tapToCrossButton() {
        if let indexPath {
            delegate?.skillsCell(self, didRemoveAt: indexPath)
        }
    }
    
    //MARK: - Methods
    func setupElements() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - 48 - 16 - 16)
        ])
    }
    
    func setup(model: SkillsCellModel) {
        label.text = model.title
        
        if model.isEditing {
            stackView.addArrangedSubview(crossButton)
        } else {
            crossButton.removeFromSuperview()
        }
    }
}
