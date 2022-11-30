//
//  CoreDataManager.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 28.11.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        managedContext = persistentContainer.viewContext
    }
    
    func saveNote(episode: String, season: String, text: String,
                  comletion: @escaping(CoreDataCustomSuccesMessage?, CoreDataCustomError?) -> Void ){
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let noteModel = NSManagedObject(entity: entity, insertInto: managedContext)
        noteModel.setValue(episode, forKeyPath: "episode")
        noteModel.setValue(season, forKey: "season")
        noteModel.setValue(text, forKey: "text")
        noteModel.setValue(UUID(), forKey: "uuid")
        
        
        do {
            try managedContext.save()
            comletion(CoreDataCustomSuccesMessage.saveSuccess,nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        comletion(CoreDataCustomSuccesMessage.saveSuccess,nil)
    }
    
    func getNotes(completion: @escaping([Notes],CoreDataCustomError?) -> Void ){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            completion(notes as! [Notes],nil)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion([],CoreDataCustomError.loadError)
        }
        
    }
    
    func deleteNote(note: Notes, completion: @escaping(CoreDataCustomError?,CoreDataCustomSuccesMessage?) -> Void) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
            completion(nil,CoreDataCustomSuccesMessage.deleteSucces)
        } catch let error as NSError {
            completion(CoreDataCustomError.deleteError, nil)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insert(model: Notes){
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        var noteModel = NSManagedObject(entity: entity, insertInto: managedContext)
        noteModel = model
        managedContext.insert(noteModel)
        
    }
    
    
    func updateNote(note: Notes){
        insert(model: note)
    }
}

//MARK: - Enums

//Core Data Custom Error
enum CoreDataCustomError {
    case saveError
    case loadError
    case updateError
    case deleteError
}

extension CoreDataCustomError {
    var message: String {
        switch self {
        case .loadError:
            return "Failed to load notes from core data"
        case .saveError:
            return "Failed to save note to core data"
        case .updateError:
            return "Failed to update note"
        case .deleteError:
            return "Failed to delete note from core data"
        }
    }
}


//Core Data Custom Success Message
enum CoreDataCustomSuccesMessage {
    case saveSuccess
    case updateSucces
    case deleteSucces
}

extension CoreDataCustomSuccesMessage {
    var message: String {
        switch self {
        case .saveSuccess:
            return "Note saved successfully"
        case .updateSucces:
            return "Note edited successfully"
        case .deleteSucces:
            return "Note deleted successfully"
        }
    }
}
