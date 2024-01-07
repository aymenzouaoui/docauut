//
//  DetailsViewController.swift
//  amongus
//
//  Created by Apple Esprit on 30/12/2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    var playerName:String?
    var playerColor:String?
    // var
 
    
    //widgets
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    //life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        playerImageView.image = UIImage(named: playerColor!)
        playerNameLabel.text = playerName
    }
    
    // methods
    func ifExistMethod() -> Bool {
        
        var mBoolean = false
        let appDelagte = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagte.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Player")
        let predicate = NSPredicate(format: "name = %@", playerName!)
        
        request.predicate = predicate
        
        do{
            
            let result = try managedContext.fetch(request)
            
            if result.count > 0  {
                
                mBoolean = true
                
            }
        }catch{
            print("Player fetching error")
            
        }
        return mBoolean
    }

    //..
    func addPlayer(){
        let appDelagte = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagte.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDesscription = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)
        
        let object = NSManagedObject(entity: entityDesscription!, insertInto: managedContext)
        object.setValue(playerName, forKey: "name")
        object.setValue(playerColor, forKey: "color")
        
        do{
            try managedContext.save()
            self .alertMethod(titre: "Succes", message: "Player is marked as suspect ")
        }catch {
            print(" suspect Adding error")
        }
    }
    
    
    //..
    
    func alertMethod(titre: String , message: String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default , handler: nil)
        alert.addAction(action)
        self.present(alert , animated: true , completion: nil)
    }

    
    //IBActions
    
    @IBAction func markAsSuspectAction(_ sender: Any) {
        
        if !ifExistMethod(){
          
            addPlayer()
            
            
            
        }else{
            self .alertMethod(titre: "warning", message: "Player is already marked as suspect ")
            
        }
    }
}
