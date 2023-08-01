//
//  CoreDataManager.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    private let container = NSPersistentContainer(name: "CoreDataResume")
    private let skillEntityName = "DBSkill"
    
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {}
    
    /// Регистрация контейнера
    func registerContainer(completion: (() -> Void)? = nil) {
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            } else {
                completion?()
            }
        })
    }

    func getMessages(completion: @escaping ([DBSkill]) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let request = NSFetchRequest<DBSkill>(entityName: self.skillEntityName)
                let skills = try self.context.fetch(request)
                completion(skills)
            }
            catch {
                completion([])
                print("Messages not found")
            }
        }
    }
    
    func save(skill: String) {
        do {
            let dbSkill = DBSkill(context: context)
            dbSkill.title = skill
            
            try context.save()
        }
        catch {
            print("Can't save message")
        }
    }
    
    func delete(skill: String) {
        do {
            let request = NSFetchRequest<DBSkill>(entityName: self.skillEntityName)
            let tasks = try self.context.fetch(request)
            if let task = tasks.first(where: { $0.title == skill }) {
                context.delete(task)
                try context.save()
            }
        }
        catch {
            print("Delete error")
        }
    }
}
