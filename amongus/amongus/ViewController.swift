//
//  ViewController.swift
//  amongus
//
//  Created by Apple Esprit on 30/12/2023.
//

import UIKit

class ViewController: UIViewController {

    
    
    //var
    

    //widgets
    
    
    @IBOutlet weak var AvatarNameTF: UITextField!
    @IBOutlet weak var AvatarImageView: UIImageView!
    //life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue" {
            let destination = segue.destination as! HomeViewController
            destination.avatarName = AvatarNameTF.text
            
        }
    }

//IBactions
    
    @IBAction func startAction(_ sender: Any) {
        performSegue(withIdentifier: "firstSegue", sender: sender)
    }
    
    
    //..
    
    @IBAction func redbtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Red")
    }
    //..
    
    @IBAction func yellowbtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Yellow")
    }
    //..
    
    @IBAction func brownbtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Brown")
    }
    //..
    
    @IBAction func lightbluebtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Light-blue")
    }
    //..
    @IBAction func orangebtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Orange")
    }
    
    //..
    @IBAction func purpulebtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Purple")
    }
    
    //..
    
    
    @IBAction func rosebtnAction(_ sender: Any) {
        AvatarImageView.image=UIImage(named: "Rose")
    }
}

