//
//  TopPlayersViewController.swift
//  LiverpoolExam
//
//  Created by Khaled Guedria on 1/7/21.
//  Copyright © 2021 Khaled Guedria. All rights reserved.
//

import UIKit
import CoreData

class TopPlayersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    
    //VAR
    var topPlayers = [String]()
    var positions = [String]()
    var ratings = [Int32]()
    
    
    
    //WIDGETS
    
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    
    //datasource protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topPlayers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell2", for: indexPath)
        
        let cv = cell.contentView
        
        let imageview = cv.viewWithTag(1) as! UIImageView
        let ratingLabel = cv.viewWithTag(2) as! UILabel
        
        imageview.image = UIImage(named: topPlayers[indexPath.row])
        ratingLabel.text = String(ratings[indexPath.row])
        
        return cell
    }
    
    //..
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if MOTSExists() {
            alertMessage(message: "You have already voted!")
        }else {
            insertItem(name: topPlayers[indexPath.row], position: positions[indexPath.row])
        }
        
    }
    
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        retreiveData()
        // Do any additional setup after loading the view.
    }
    
    //..
    
    func retreiveData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Player")
        let predicate = NSPredicate(format: "rating > %d", 7)
        request.predicate = predicate
        
        do {
            
            let data = try managedContext.fetch(request)
            for item in data {
                
                topPlayers.append(item.value(forKey: "name") as! String)
                positions.append(item.value(forKey: "position") as! String)
                ratings.append(item.value(forKey: "rating") as! Int32)
            }
            
        } catch  {
            
            print("Fetching error !")
        }
        
    }
    
    //..
    func alertMessage(message: String) {
        
        let alert = UIAlertController(title: "Vote", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    //..
    
    func insertItem(name: String, position: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "MOTS", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(name, forKey: "name")
        object.setValue(position, forKey: "position")

        
        do {
            
            try managedContext.save()
            alertMessage(message: "You voted for " + name + " as MOTS.")
            
        } catch {
            
            alertMessage(message:"MOTS insert error !")
        }

    }
    
    //..
    
    func MOTSExists() -> Bool{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        var MOTSExist = false
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "MOTS")
        
        do {
            
            let data = try managedContext.fetch(request)
            if data.count > 0 {
                MOTSExist = true
            }
            
        } catch  {
            
            print("Fetching error !")
        }
        
        return MOTSExist
    }
    
    
    //IBActions

    
    
    
    @IBAction func toMOTSAction(_ sender: Any) {
        
      if MOTSExists() {
        performSegue(withIdentifier: "mSegue3", sender: sender)
    }
        
}

}
