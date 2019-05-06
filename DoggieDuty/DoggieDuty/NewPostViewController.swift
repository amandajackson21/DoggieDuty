//
//  NewPostViewController.swift
//  DoggieDuty
//
//  Created by Amanda Jackson on 4/29/19.
//  Copyright © 2019 Amanda Jackson. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    var pets = [PFObject]()
    var petNameList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        postTextField.borderStyle = UITextField.BorderStyle.roundedRect

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let query = PFQuery(className: "Pets")
        query.limit = 20
        query.findObjectsInBackground { (pets, error) in
            if pets != nil{
                self.pets = pets!
                for x in self.pets {
                    self.petNameList.append(x["name"] as! String)
                    self.pickerView.reloadAllComponents()
                }
            }
        }
    }

    //let test = ["Cat", "banana", "Buddy", "Chuck Bass", "bunny"]// the test works but when I do it with petNameList it doesn't :(
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return petNameList.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return petNameList[row]
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let selectedValue = petNameList[pickerView.selectedRow(inComponent: 0)]
        let post = PFObject(className: "Posts")
        post["content"] = postTextField.text
        post["author"] = PFUser.current()!
        post["petName"] = selectedValue
        var pickedPet = PFObject(className: "Pets")
        for x in pets{
            if x["name"] as! String == selectedValue{
               pickedPet = x
            }
        }

        post["image"] = pickedPet["image"]
            
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
