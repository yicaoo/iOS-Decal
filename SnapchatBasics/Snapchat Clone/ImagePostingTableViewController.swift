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
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return threadNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstant.postLabelCell, for: indexPath)
        // label the cell based on category
        if let cell = cell as? PostImageTableViewCell {
            cell.cellLabel.text = threadNames[indexPath.row]
        }
        return cell
    }
    
    @IBAction func postSelectedImage(_ sender: UIBarButtonItem) {
        if let category = selectedCategroy.title, let image = imageToPost, let _ = threads[selectedCategroy.title!] {
            let snap = Snap(image: image, timeStamp: Date())
            threads[category]?.append(snap)
            issuePostingAlert()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategroy.title = threadNames[indexPath.row]
    }

    private func issuePostingAlert() {
        let alert = UIAlertController(title: AlertConstant.sucess, message: AlertConstant.postedMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AlertConstant.done, style: .default, handler: {action in
                //unwind to image selector page
                self.performSegue(withIdentifier: StoryboardConstant.unwindeSegue, sender: self)
            }))
            self.present(alert, animated: true)
    }

    // MARK: - Constants
    private struct StoryboardConstant {
        static let postLabelCell = "postLabelCell"
        static let unwindeSegue = "unwindSegueToImagePicker"
    }
    
    private struct AlertConstant {
        static let sucess = "Sucess"
        static let done = "Done"
        static let postedMessage = "Image successfully posted"
    }
    
}
