//
//  NewPostViewController.swift
//  DoggieDuty
//
//  Created by Amanda Jackson on 4/29/19.
//  Copyright © 2019 Amanda Jackson. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var postTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTextField.borderStyle = UITextField.BorderStyle.roundedRect

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
       
        let post = PFObject(className: "Posts")
        post["content"] = postTextField.text
        post["author"] = PFUser.current()!
        PFUser.current()?.setObject(post["username"], forKey: "username")
            
        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var destViewController : FeedTableViewController = segue.destination as! FeedTableViewController
//
//        destViewController.postText = postTextField.text ?? "test"
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
