//
//  ImagePostingTableViewController.swift
//  Snapchat Clone
//
//  Created by Yi Cao on 10/19/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class ImagePostingTableViewController: UITableViewController {
    var imageToPost: UIImage?
    @IBOutlet weak var selectedCategroy: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return threadNames.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postLabelCell", for: indexPath)
        if let cell = cell as? PostImageTableViewCell {
            cell.cellLabel.text = threadNames[indexPath.row]
        }
        return cell
    }
    
    @IBAction func postSelectedImage(_ sender: UIBarButtonItem) {
        print("here")
        if let category = selectedCategroy.title, let image = imageToPost, let _ = threads[selectedCategroy.title!] {
           threads[category]?.append(image)
            print("!!!"+String(threads[category]!.count))
            issuePostingAlert()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategroy.title = threadNames[indexPath.row]
    }

    private func issuePostingAlert() {
        let alert = UIAlertController(title: "Sucess", message: "Image successfully posted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {action in
                //unwind to image selector page
                self.performSegue(withIdentifier: "unwindSegueToImagePicker", sender: self)
            }))
            self.present(alert, animated: true)
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
