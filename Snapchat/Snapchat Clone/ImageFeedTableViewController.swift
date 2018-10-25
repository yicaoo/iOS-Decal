//
//  ImageFeedTableViewController.swift
//  Snapchat Clone
//
//  Created by Yi Cao on 10/19/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class ImageFeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return threadNames.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return threads[threadNames[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return threadNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        if let feedCell = cell as? FeedTableViewCell, let snaps = threads[threadNames[indexPath.section]] {
            let snap = snaps[indexPath.row]
            // read status
            if snap.read {
                feedCell.readStatus.image = UIImage(named: "read")
            } else {
                feedCell.readStatus.image = UIImage(named: "unread")
            }
            // time interval
            let elapsedMin = Int(Date().timeIntervalSince(snap.timeStamp)) / 60
            feedCell.timeStamp.text = "\(elapsedMin) Minute Ago"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let snaps = threads[threadNames[indexPath.section]] {
            let snap = snaps[indexPath.row]
            if !snap.read {
            snap.markAsRead()
            performSegue(withIdentifier: "displayImage", sender: snap)
            //tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let snap = sender as? Snap, let destination = segue.destination as? ViewImageViewController {
            destination.fullImage = snap.image
        }
    }
    

}
