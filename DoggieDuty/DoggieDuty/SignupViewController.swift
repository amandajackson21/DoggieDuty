//
//  SignupViewController.swift
//  DoggieDuty
//
//  Created by Hailey Cassidy on 4/20/19.
//  Copyright © 2019 Amanda Jackson. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        if passwordField.text == rePasswordField.text{
            user.password = passwordField.text
        }else {
            print("Passwords do not match")
        }
        
        user.signUpInBackground { (success
            , error) in
            if success{
                self.performSegue(withIdentifier: "SignupSuccessSegue", sender: nil)
            }else{
                print("Error: \(error?.localizedDescription)")
            }
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
