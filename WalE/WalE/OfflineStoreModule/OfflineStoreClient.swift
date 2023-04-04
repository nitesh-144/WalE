//
//  OfflineStoreClient.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import CoreData

protocol OfflineServiceProtocol{
    func saveImageDataToDB(imageModel model: ImageDataModel)
    func clearDB()
    func getImageData() -> ImageDataModel?
}

class OfflineStore: OfflineServiceProtocol{
    
    private init(){}
    static let shared: OfflineStore = OfflineStore()
    
    //CoreData Stack
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WalE_DB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //methods
    func saveImageDataToDB(imageModel model: ImageDataModel) {
        let imgDataToSave = CDImageData(context: persistentContainer.viewContext)
        imgDataToSave.imageName = model.title
        imgDataToSave.imageDescription = model.explanation
        imgDataToSave.imageUrl = model.url
        
        if let url = URL(string: imgDataToSave.imageUrl ?? ""){
            imgDataToSave.imageContent = try? Data(contentsOf: url)
        }
        saveContext()
    }
    
    func clearDB() {
        let fetchRequest = CDImageData.fetchRequest()
        if let objects = try? persistentContainer.viewContext.fetch(fetchRequest){
            for obj in objects{
                persistentContainer.viewContext.delete(obj)
            }
            
            saveContext()
        }
    }
    
    func getImageData() -> ImageDataModel? {
        
        let fetchRequest = CDImageData.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        if let model = try? persistentContainer.viewContext.fetch(fetchRequest).first{
            var modelToReturn = PicOfTheDay()
            modelToReturn.title = model.imageName
            modelToReturn.explanation = model.imageDescription
            modelToReturn.url = model.imageUrl
            modelToReturn.imageContentData = model.imageContent
            return modelToReturn
        }
        
        return nil
    }
}
