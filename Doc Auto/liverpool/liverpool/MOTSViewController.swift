//
//  MOTSViewController.swift
//  LiverpoolExam
//
//  Created by Khaled Guedria on 1/7/21.
//  Copyright © 2021 Khaled Guedria. All rights reserved.
//

import UIKit
import CoreData

class MOTSViewController: UIViewController {
    
    //var
    var player = ""
    
    //widgets
    
   
    
    
    @IBOutlet weak var MOTS: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retreiveData()
        MOTS.image = UIImage(named: player)
        // Do any additional setup after loading the view.
    }

    //functions
    func retreiveData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "MOTS")
        
        do {
            
            let data = try managedContext.fetch(request)
            for item in data {
                
                player = item.value(forKey: "name") as! String

            }
            
        } catch  {
            
            print("Fetching error !")
        }
        
    }
    
    

}
