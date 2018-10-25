//
//  ViewImageViewController.swift
//  Snapchat Clone
//
//  Created by Yi Cao on 10/19/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class ViewImageViewController: UIViewController {
    var fullImage: UIImage?
    @IBOutlet weak var imageDisplay: UIImageView! {
        didSet {
            if let image = fullImage {
                imageDisplay.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss(_sender:)))
        view.addGestureRecognizer(tap)
    }
    @objc func tapToDismiss(_sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
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
