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
       return threads[threadNames[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return threadNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstant.feedcell, for: indexPath)
        if let feedCell = cell as? FeedTableViewCell, let snaps = threads[threadNames[indexPath.section]] {
            let snap = snaps[indexPath.row]
            // read status
            if snap.read {
                feedCell.readStatus.image = UIImage(named: ImageCellConstant.read)
            } else {
                feedCell.readStatus.image = UIImage(named: ImageCellConstant.unread)
            }
            // time interval
            let elapsedMin = Int(Date().timeIntervalSince(snap.timeStamp)) / ImageCellConstant.min
            feedCell.timeStamp.text = "\(elapsedMin)" + ImageCellConstant.timeString
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let snaps = threads[threadNames[indexPath.section]] {
            let snap = snaps[indexPath.row]
            if !snap.read {
            snap.markAsRead()
            performSegue(withIdentifier: StoryboardConstant.displayImageSegue, sender: snap)
            //tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let snap = sender as? Snap, let destination = segue.destination as? ViewImageViewController {
            destination.fullImage = snap.image
        }
    }
    
    // MARK: - Constants
    private struct StoryboardConstant {
        static let feedcell = "feedCell"
        static let displayImageSegue = "displayImage"
    }
    
    private struct ImageCellConstant {
        static let read = "read"
        static let unread = "unread"
        static let timeString = " Minute Ago"
        static let min = 60
    }
}
