//
//  ViewController.swift
//  liverpool
//
//  Created by Mac Mini 3 on 3/1/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var
    var players = ["Alisson Becker", "Andy Robertson", "Fabinho Tavares", "Gini Wijnaldum","James Milner", "Joe Gomez", "Jordan Henderson", "Mohamed Salah", "Roberto Firmino", "Sadio Mane", "Trent Alexander Arnold", "Virgil Van Dijk", "Adrian"]
    
    var positions = ["GK", "LB", "CDM", "CM","CM", "CB", "CDM", "RW", "CF", "LW", "RB", "CB", "GK"]
    
    
    //widgets
    
    
    
    
    //Datasource protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell1")
        let cv = cell?.contentView
        
        let imageview = cv?.viewWithTag(1) as! UIImageView
        let nameLabel = cv?.viewWithTag(2) as! UILabel
        let positionLabel = cv?.viewWithTag(3) as! UILabel
        
        
        imageview.image = UIImage(named: players[indexPath.row])
        nameLabel.text = players[indexPath.row]
        positionLabel.text = positions[indexPath.row]
        
        
        return cell!
    }
    
    //Delegate protocol
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "mSegue1", sender: indexPath)
        
    }

    
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    //functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mSegue1" {
            let index = sender as! IndexPath
            let destination = segue.destination as! DetailsViewController
            destination.playerName = players[index.row]
            destination.playerPosition = positions[index.row]
        }
    }
    
    
    
    
    
    //IBActions
 
    @IBAction func TopPlayersActions(_ sender: Any) {
        performSegue(withIdentifier: "mSegue2", sender: sender)
    }
    

}

