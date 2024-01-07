//
//  DetailsViewController.swift
//  WorkshopIOSTV
//
//  Created by Torkhani fara on 26/12/2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    //var
    var movieTitle:String?
    
    
    
    //widgets

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.image = UIImage(named: movieTitle!)
        movieLabel.text = movieTitle!
        // Do any additional setup after loading the view.
    }
    

    
    func insertItem() {
        
        let appdelegate = UIApplication.shared.delegate  as! AppDelegate
        let persistentContainer = appdelegate.persistentContainer //interaction avec bd
        let managedContext = persistentContainer.viewContext //copie ly bch ninseri feha  de type NSmanaged context mawjouda f ram
        
        //definir schema
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext) //enity schema
        
        
        let object =  NSManagedObject(entity: entityDescription!, insertInto: managedContext) // contructor
        
        
        
        object.setValue(movieTitle!, forKey: "movieName")

        
        do {
            try managedContext.save()
            print("insert sucessufully")
        } catch  {
            print("error")
        }

    }
    
    
    func checkMovie() -> Bool {
        var movieExist = false
        let appdelegate = UIApplication.shared.delegate  as! AppDelegate
        let persistentContainer = appdelegate.persistentContainer //interaction avec bd
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "movieName = %@", movieTitle!)
        
        request.predicate  = predicate
        
        
        
        do {
          let result =  try managedContext.fetch(request)
            
            if result.count > 0 {
                movieExist = true
            }
         } catch  {
            print("error")
        }
    
        
        return movieExist
    }
    @IBAction func saveMovie(_ sender: Any) {
        if checkMovie() {
            let alert = UIAlertController(title: "warning", message: "Movie Already exists", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it ", style: .cancel, handler: nil)
            
            
            alert.addAction(action)
            
            self.present(alert,animated: true)
            
            
        } else {
            insertItem()
        }
    }
    
}
