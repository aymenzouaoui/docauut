//
//  FavoritesViewController.swift
//  WorkshopIOSTV
//
//  Created by Chawki Ferroukhi on 28/12/2023.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate{
    
    //point dexlamation  !
    
    var favorites = [String]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        let imageView = contentView?.viewWithTag(2) as! UIImageView
        
        
        label.text = favorites[indexPath.row]
        
        imageView.image = UIImage(named: favorites[indexPath.row])
        
        return cell!
    }
    
    

    
    // Cell onClicklistener
    override func viewDidLoad() {
        super.viewDidLoad()
            fetchData() 
        // Do any additional setup after loading the view.
    }
    
    
    func fetchData()   {
        let appdelegate = UIApplication.shared.delegate  as! AppDelegate
        let persistentContainer = appdelegate.persistentContainer //interaction avec bd
        let managedContext = persistentContainer.viewContext //copie ly bch ninseri feha  de type NSmanaged
        
        
        let request = NSFetchRequest<NSManagedObject>(entityName:"Movie")
        
        
        do {
           let result =  try managedContext.fetch(request)
            for item in result {
                favorites.append(item.value(forKey: "movieName") as! String)
            }
        } catch {
            print ("error catching")
        }
    }

    
    //supprimer
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(index: indexPath.row) // Your custom function to delete an item
            tableView.deleteRows(at: [indexPath], with: .automatic) // Instead of reloadData()
            print("deleting...")
        }
    }

    
    func deleteItem(index: Int)  {
        let appdelegate = UIApplication.shared.delegate  as! AppDelegate
        let persistentContainer = appdelegate.persistentContainer
        let managedContext = persistentContainer.viewContext

        let request = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "movieName = %@", favorites[index])
        
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                let objToDelete = result[0]
                managedContext.delete(objToDelete)
                favorites.remove(at: index) // Remove the item from your data source.
                
                try managedContext.save() // Save the changes in CoreData.
                print("Deleted successfully")
            }
        } catch let error as NSError {
            print("Delete error: \(error), \(error.userInfo)")
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
