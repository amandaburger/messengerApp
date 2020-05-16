//
//  registerVC.swift
//  practiceMessenger
//
//  Created by Amanda Burger on 5/12/20.
//  Copyright © 2020 Amanda Burger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD
class registerVC: UIViewController {
    //text fields
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //register button pressed
    @IBAction func registerPressed(_ sender: Any) {
        
        do{
        //try Auth.auth().signOut()
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            if error != nil{
                print(error!)
            }
            else{
                //success
                print("success")
                
                self.performSegue(withIdentifier: "logout", sender: self)
            }
        }
    
    }
    catch{
    print(error)
    }
    }
}
