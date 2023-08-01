//
//  ViewController.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var profileView = ProfileView()
    private lazy var skillsView = SkillsView()
    private lazy var aboutMeView = AboutMeView()
    
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        skillsView.delegate = self
        if UserDefaults.standard.bool(forKey: "isFirstLounch") {
            [
                SkillsCellModel(title: "ООП", isEditing: false),
                SkillsCellModel(title: "SOLID", isEditing: false),
                SkillsCellModel(title: "CoreData", isEditing: false),
                SkillsCellModel(title: "UIKit", isEditing: false)
            ].forEach {
                CoreDataManager.shared.save(skill: $0.title)
            }
        }
        UserDefaults.standard.set(false, forKey: "isFirstLounch")
        setupElements()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(
            width: view.frame.width,
            height: profileView.frame.height + skillsView.frame.height + aboutMeView.frame.height
        )
    }
    
    private func setupElements() {
        view.addSubview(scrollView)
        scrollView.addSubview(profileView)
        scrollView.addSubview(skillsView)
        scrollView.addSubview(aboutMeView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profileView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            profileView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            skillsView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            skillsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            skillsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            aboutMeView.topAnchor.constraint(equalTo: skillsView.bottomAnchor),
            aboutMeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            aboutMeView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            aboutMeView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func openNewSkillAlert() {
        let alertController = UIAlertController(
            title: "Добавление навыка",
            message: "Введите название навыка которым вы владеете",
            preferredStyle: .alert
        )
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Введите название"
        }
        let addAction = UIAlertAction(title: "Добавить", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            
            if let newSkill = textField.text {
                self.skillsView.addNew(newSkill)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: SkillsViewDelegate {
    func skillsViewDidOpenNewSkill(_ view: SkillsView) {
        openNewSkillAlert()
    }
}
