//
//  detailViewController.swift
//  examenLiverPool
//
//  Created by Chawki Ferroukhi on 3/1/2024.
//

import UIKit
import CoreData

class detaillViewController: UIViewController {

    
    var playerNamee:String?
    var rating = 4
    var playerPosition:String?
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!

    @IBAction func onValueChangedValue(_ sender: UISlider) {
        rating = Int(sender.value)
    ratingLabel.text = String(Int(sender.value))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: playerNamee!)
        playerNameLabel.text = playerNamee
    }
   
    
    func alertMessage(message: String) {
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func insertItem() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        
        object.setValue(playerNamee!, forKey: "name")
        object.setValue(rating, forKey: "rating")
        object.setValue(playerPosition!, forKey: "position")

        
        do {
            
            try managedContext.save()
            alertMessage(message: "Player added successfully !")
            
        } catch {
            
            alertMessage(message:"Player insert error !")
        }

    }
    
    
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
    
    @IBAction func SavePlayerAction(_ sender: Any) {
            insertItem()
        

    }
    
}
