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
    
    func saveNote(episode: String, season: String, text: String) -> Notes? {
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let noteModel = NSManagedObject(entity: entity, insertInto: managedContext)
        noteModel.setValue(episode, forKeyPath: "episode")
        noteModel.setValue(season, forKey: "season")
        noteModel.setValue(text, forKey: "text")
        
        
        do {
            try managedContext.save()
            return noteModel as? Notes
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Notes]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteNote(note: Notes) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
