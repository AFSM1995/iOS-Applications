//
//  AppDelegate.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
        
    // MARK: - Core Data stack
    // NSPersistentContainer is a fancy Database ex: can use XML and SQL.
    lazy var persistentContainer: NSPersistentContainer = {
        // Set up the database.
        let container = NSPersistentContainer(name: "DataModel")
        // Load the database and check for errors.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // Resturn the database as the Lazy var above.
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        // Essentially were you change and update your data ex: Undo and redu.
        // Like staging area in git.
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                // Like commiting the data in git.
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
