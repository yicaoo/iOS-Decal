//
//  imageFeed.swift
//  snapChatProject
//
//  Created by Akilesh Bapu on 2/27/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import Foundation
import UIKit

class Snap {
    let image: UIImage
    let timeStamp: Date
    // sender will be added later
    var read: Bool
    
    init(image: UIImage, timeStamp: Date) {
        self.image = image
        self.timeStamp  = timeStamp
        self.read = false
    }
    
    func markAsRead() {
        read = true
    }
}

var threads: [String: [Snap]] = ["memes": [], "dog spots": [], "random": []]

let threadNames = ["memes", "dog spots", "random"]

// The images used to populate the collection view in ImagePickerController
var allImages: [UIImage] = [UIImage(named: "dog1")!,
                            UIImage(named: "meme1")!,
                            UIImage(named: "other1")!,
                            UIImage(named: "dog2")!,
                            UIImage(named: "meme2")!,
                            UIImage(named: "other2")!,
                            UIImage(named: "dog3")!,
                            UIImage(named: "meme3")!,
                            UIImage(named: "other3")!]
