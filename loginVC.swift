



import Foundation
import UIKit
import Firebase
class loginVC: UIViewController {

    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
             if error != nil{
                print(error!)
                }
            else{
                //success
                print("success")
                self.performSegue(withIdentifier: "goToChat", sender: self)
                }
        }
    }
    
}
