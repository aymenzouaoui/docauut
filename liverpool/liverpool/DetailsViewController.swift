//
//  DetailsViewController.swift
//  LiverpoolExam
//
//  Created by Khaled Guedria on 1/7/21.
//  Copyright © 2021 Khaled Guedria. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    
    //var
    var playerName : String?
    var playerPosition : String?
    var rating = 5
    
    
    //widgets
   
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var PlayerNameLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.image = UIImage(named: playerName!)
        PlayerNameLabel.text = playerName
        // Do any additional setup after loading the view.
    }

    
    //functions
    func alertMessage(message: String) {
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    //..
    func insertItem() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(playerName!, forKey: "name")
        object.setValue(playerPosition!, forKey: "position")
        object.setValue(rating, forKey: "rating")
        
        do {
            
            try managedContext.save()
            alertMessage(message: "Player added successfully !")
            
        } catch {
            
            alertMessage(message:"Player insert error !")
        }

    }
    
    //..
    
    func getByCreateria(name: String) -> Bool{
        
        var playerExist = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                playerExist = true
                self.alertMessage(message: "Player already added!")
                
            }
            
        } catch {
            
            print("Fetching by criteria error !")
        }
        
        
        return playerExist
    }
    
    
    
    
    //IBActions

    
    @IBAction func onValueChangedSliderAction(_ sender: UISlider) {
        rating = Int(sender.value)
        ratingLabel.text = String(Int(sender.value))
    }
    //..

    
    
    
 


    @IBAction func savePlayerAction(_ sender: Any) {
        if !getByCreateria(name: playerName!) {
            insertItem()
        }
    }
}
