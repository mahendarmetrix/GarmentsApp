//
//  CoredataManager.swift
//  Garments
//
//  Created by Mahedndar Ramidi on 6/7/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let writeQueue = DispatchQueue(label: "com.serial.DBWrite")

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Garments")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var writeContext: NSManagedObjectContext =  {
        return self.persistentContainer.newBackgroundContext()
    }()
}

// MARK: - Core Data CRUD operations

extension CoreDataManager {
    private func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAllGarments(sortedBy key: String) -> [GarmentData] {
        var garmentsData = [GarmentData]()
        let fetchReq = Garment.fetchRequest()
        let sectionSortDescriptor = NSSortDescriptor(key: key, ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchReq.sortDescriptors = sortDescriptors
        do {
            let garments = try persistentContainer.viewContext.fetch(fetchReq)
            for garment in garments {
                garmentsData.append(GarmentData(garment: garment))
            }
        } catch {
            
        }
        return garmentsData
    }
    
    func getGarmentWithName(_ name: String) -> Garment? {
        let fetchReq = Garment.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchReq.predicate = predicate
        do {
            let garments = try persistentContainer.viewContext.fetch(fetchReq)
            return garments.first
        } catch {
            
        }
        return nil
    }
    
    func saveGarmentData(_ garmentData: GarmentData) {
        guard getGarmentWithName(garmentData.name) == nil else {
            // garment name already exists
            return
        }
        let garment = Garment(context: self.writeContext)
        garment.name = garmentData.name
        garment.creationTime = garmentData.creationTime
        saveContext(context: self.writeContext)
    }
}
