//
//  ViewController.swift
//  LogInDemoJack
//
//  Created by MACBOOK on 16/04/2017.
//  Copyright © 2017 jack_amiegbe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var logInButton: UIButton!
    
    
    @IBAction func logIn(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newValue.setValue(textField.text, forKey: "name")
        
        do {
            try context.save()
            textField.alpha = 0
            logInButton.alpha = 0
            label.alpha = 1
            label.text = "Hi there " + textField.text! + "!"
            
        } catch {
            print("Failed to save")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    textField.alpha = 0
                    logInButton.alpha = 0
                    label.alpha = 1
                    label.text = "Hi there " + username + "!"
                }
            }
        } catch {
            print("Request failed")
            
        }
    }
    
}

