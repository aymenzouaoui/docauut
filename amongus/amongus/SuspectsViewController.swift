//
//  SuspectsViewController.swift
//  amongus
//
//  Created by Apple Esprit on 30/12/2023.
//

import UIKit
import CoreData
class SuspectsViewController: UIViewController, UICollectionViewDataSource {
  
    
    //var
    var suspects = [String]()
    var suspectColors = [String]()
    
    //widgets
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    //Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suspects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mItem", for: indexPath)
        let cv = cell.contentView
        
        let imageView = cv.viewWithTag(1) as! UIImageView
        let label = cv.viewWithTag(2) as! UILabel
        
        imageView.image = UIImage(named: suspectColors[indexPath.row])
        label.text = suspects[indexPath.row]
        
        
        
        return cell
    }
    
    
    
    
    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetching
        
        fetchSuspects()
        
        //mCollectionView.reloadData()
        
    }
    
    //methods
    
    func fetchSuspects(){
        let appDelagte = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagte.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Player")
        
        do{
           let result = try managedContext.fetch(request)
            for item in result{
                suspects.append(item.value(forKey: "name") as! String)
                suspectColors.append(item.value(forKey: "color") as! String)
                mCollectionView.reloadData()
            }
        
        }catch{
            print("fetching all errors ! ")
        }
    }



}
