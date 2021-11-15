//
//  MessageViewController.swift
//  ExamenThunder ios
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import UIKit
import CoreData

class MessageViewController: UIViewController {
    
    var senderName: String?
    var senderMessage: String?
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var message: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init the data
        image.image = UIImage(named: senderName!)
        message.text = senderMessage!
        self.navigationItem.title = senderName
    }
    
    
    func popAlert(a: String, b: String) {
        let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func check(name: String) -> Bool {
        var exist = false
        //3default
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoris")
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                exist = true
            }
                
        } catch  {
            print("error")
        }

        return exist
    }
    
    //insert
    func addFavorite() {
        //3default
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentcontainer = appdelegate.persistentContainer
        let managedContext = persistentcontainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Favoris", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(senderName!, forKey: "name")
        object.setValue(senderMessage!, forKey: "message")
        do {
            try managedContext.save()
        } catch  {
            print("failed to add")
        }
    }
    

    @IBAction func savetofavorite(_ sender: Any) {
        let test = check(name: senderName!)
        if test == false {
            addFavorite()
            popAlert(a: "Message", b: "added to favorite!")
        }
        else {
            popAlert(a: "Message", b: "already exist")

        }
    }
    
}
