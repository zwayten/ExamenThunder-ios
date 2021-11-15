//
//  ViewController.swift
//  ExamenThunder ios
//
//  Created by Yassine Zitoun on 14/11/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var persons = ["Andreas Romero", "Chelsea Watt", "Huw Oakley", "Logan Calhoun", "Marcos Redmond", "Stanley Obrien"]
    var messages = ["messgae 1", "message 2", "message 3", "message 4", "message 5", "message 6"]
    
    var datap = [String]()
    var datam = [String]()
    
    var favorite = false

    @IBOutlet var tt: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    
    @IBAction func toggle(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
                    
            retriveData()
                    tt.reloadData()
            favorite = true
                    
                }else {
                    favorite = false
                    persons = ["Andreas Romero", "Chelsea Watt", "Huw Oakley", "Logan Calhoun", "Marcos Redmond", "Stanley Obrien"]
                    messages = ["messgae 1", "message 2", "message 3", "message 4", "message 5", "message 6"]
                    //..
                    tt.reloadData()
                    
                    
                }
    }
    
    func retriveData(){
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Favoris")
        
        persons = [String]()
        messages = [String]()
                do {
                    let result = try managedContext.fetch(request)
                    for item in result {
                        persons.append(item.value(forKey: "name") as! String)
                        messages.append(item.value(forKey: "message") as! String)
                    }
                } catch  {
                    print("cannot fetch : error")
                }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return persons.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acell")
        let contentView = cell!.contentView
        
        let image = contentView.viewWithTag(1) as! UIImageView
        let namelbl = contentView.viewWithTag(2) as! UILabel
        let messagelbl = contentView.viewWithTag(3) as! UILabel
        
        
        
        image.image = UIImage(named: persons[indexPath.row])
        namelbl.text = persons[indexPath.row]
        messagelbl.text = messages[indexPath.row]
        
        //
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath
        performSegue(withIdentifier: "tomessage", sender: index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tomessage" {
            let index = sender as! IndexPath
            let destination = segue.destination as! MessageViewController
            destination.senderName = persons[index.row]
            destination.senderMessage = messages[index.row]
        }
    }
    
}

