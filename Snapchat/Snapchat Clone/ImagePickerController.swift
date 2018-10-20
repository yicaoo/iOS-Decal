//
//  imagePickerController.swift
//  snapChatProject
//
//  Created by Akilesh Bapu on 2/27/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit

// This class should remind you of lab 3. That's probably because it's exactly the same!
class ImagePickerController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var imageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.collectionViewLayout = ImageFlowLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToImagePicker(segue:UIStoryboardSegue) {
    }
    
    func selectImage(_ image: UIImage) {
        //The image being selected is passed in as "image".
        performSegue(withIdentifier: StoryboardConstant.postImage, sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = sender as? UIImage, let destination = segue.destination as? ImagePostingTableViewController {
            destination.imageToPost = image
        }
    }
    
    //DON'T MODIFY CODE HERE AND BELOW!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryboardConstant.pickImageCell, for: indexPath) as? ImageCollectionViewCell else {
            print(StoryboardConstant.dequeueErrorMessage+"\(indexPath)")
            return UICollectionViewCell()
        }
        cell.image.image = allImages[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            selectImage(selectedCell.image.image!)
        }
    }
    
    // MARK : -Constants
    private struct StoryboardConstant {
        static let postImage = "postImage"
        static let pickImageCell = "pickImageCell"
        static let dequeueErrorMessage = "error dequeuing cell at index path "
    }
}
