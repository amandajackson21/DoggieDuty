//
//  NewPetViewController.swift
//  DoggieDuty
//
//  Created by Hailey Cassidy on 4/30/19.
//  Copyright © 2019 Amanda Jackson. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class NewPetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var petNameField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancel(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAdd(_ sender: Any) {
        let pet = PFObject(className: "Pets")
        pet["name"] = petNameField.text!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        pet["picture"] = file
        
        
        pet.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }else{
                print("error")
            }
        }
    }
    @IBAction func onPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
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
