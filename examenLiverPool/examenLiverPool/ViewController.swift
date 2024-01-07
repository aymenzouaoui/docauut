//
//  ViewController.swift
//  examenLiverPool
//
//  Created by Chawki Ferroukhi on 3/1/2024.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
   var  players=["Alisson Becker", "Andy Robertson", "Fabinho Tavares", "Gini Wijnaldum",
    "James Milner", "Joe Gomez", "Jordan Henderson", "Mohamed Salah", "Roberto Firmino",
    "Sadio Mane", "Trent Alexander Arnold", "Virgil Van Dijk", "Adrian"]
    var equipe = ["GK", "LB", "CDM", "CM","CM", "CB", "CDM", "RW", "CF", "LW", "RB", "CB", "GK"]
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
          return players.count //6 elemnts
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
          let contentView = cell?.contentView
          
          
          let playerImg = contentView?.viewWithTag(1) as! UIImageView
          let playername = contentView?.viewWithTag(2) as! UILabel
          let playerEquipe = contentView?.viewWithTag(3) as! UILabel
          
          playerImg.image = UIImage(named: players[indexPath.row])
          playername.text = players[indexPath.row]
          playerEquipe.text = equipe[indexPath.row]
          
      
          
          return cell!
      }
      
      
      // Cell onClicklistener
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let players = players[indexPath.row]
              performSegue(withIdentifier: "firstsegue", sender: indexPath)
      }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstsegue" {
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! detaillViewController
            destination.playerNamee = players[indexPath.row]
            destination.playerPosition = equipe[indexPath.row]

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TopActions(_ sender: Any) {
    performSegue(withIdentifier: "mSegue2", sender: sender)

    }


}

