//
//  FeedTableViewController.swift
//  DoggieDuty
//
//  Created by Amanda Jackson on 4/27/19.
//  Copyright © 2019 Amanda Jackson. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedTableViewController: UITableViewController{

    @IBOutlet var feedTableView: UITableView!
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
       
        query.includeKeys(["pet", "content", "content.author", "time"])
        query.limit = 20
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//        let post = posts[indexPath.section]
//        let postContent = (post["content"] as? [PFObject]) ?? []
//
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell") as! PostCellTableViewCell
//
//        let user = post["author"] as! PFUser
//
        cell.usernameLabel.text = LoginViewController().getUsername()
//        cell.postContentLabel.text = post["content"] as? String
//
//        let imageFile = post["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        cell.photoView.af_setImage(withURL: url)
//
//        return cell
//        }else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell") as! PostCellTableViewCell
        
            return cell
    }
    // }

    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let post = posts[section]
//        let postContent = (post["content"] as? [PFObject]) ?? []
//
//        return postContent.count
        return 5
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
    
}
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
            
        let main = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = LoginViewController
        
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
