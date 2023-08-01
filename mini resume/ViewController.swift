//
//  ViewController.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private let profileView = ProfileView()
    private let skillsView = SkillsView()
    
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
        setupConstraints()
    }

    private func setupElements() {
        view.addSubview(profileView)
        view.addSubview(skillsView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skillsView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            skillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skillsView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
