//
//  ViewController.swift
//  Storage
//
//  Created by Supawit Ruen on 22/11/2563 BE.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveCoreData()
        readCoreData()
    }
    
    func saveCoreData() {
        /// 1. prepare context
        /// 2. prepare entity - User
        /// 3. SetValue to keys in entity
        /// 4. Save
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        let newUser = NSManagedObject(entity: userEntity, insertInto: context)
        newUser.setValue("1", forKey: "age")
        newUser.setValue("fireb@!!", forKey: "password")
        newUser.setValue("odds", forKey: "username")
        do {
            try context.save()
            print("save success")
        } catch {
            print("save fail :: \(error.localizedDescription)")
        }
    }
    
    func readCoreData() {
        /// 1.  Prepare request
        /// 2. Fetch result
        /// 3. Iterate array
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let username = data.value(forKey: "username") as! String
                print("username :: \(username)")
            }
        } catch {
            print("fetch error :: \(error.localizedDescription)")
        }
    }
    
    
}

