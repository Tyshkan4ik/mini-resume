//
//  ViewController.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var profileView = ProfileView()
    private lazy var skillsView = SkillsView()
    private lazy var aboutMeView = AboutMeView()
    
    
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
        view.addSubview(aboutMeView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skillsView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            skillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skillsView.heightAnchor.constraint(equalToConstant: 300),
            
            aboutMeView.topAnchor.constraint(equalTo: skillsView.bottomAnchor),
            aboutMeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutMeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutMeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
