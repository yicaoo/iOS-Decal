//
//  imageFeed.swift
//  SnapchatProject
//
//  Created by Akilesh Bapu on 2/27/17. Modified by Yi.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import Firebase

var threads: [String: [Post]] = [SnapCloneConstants.memes: [], SnapCloneConstants.dog: [], SnapCloneConstants.random: []]

let threadNames = [SnapCloneConstants.memes, SnapCloneConstants.dog, SnapCloneConstants.random]

var allImages: [UIImage] = [#imageLiteral(resourceName: "cutePuppy"), #imageLiteral(resourceName: "berkAtNight"), #imageLiteral(resourceName: "meme1"), #imageLiteral(resourceName: "Campanile"), #imageLiteral(resourceName: "meme2"), #imageLiteral(resourceName: "dankMeme2"), #imageLiteral(resourceName: "amazingCutePuppy"), #imageLiteral(resourceName: "cutePuppy"), #imageLiteral(resourceName: "dirks"), #imageLiteral(resourceName: "dankMeme3")]

func getPostFromIndexPath(indexPath: IndexPath) -> Post? {
    let sectionName = threadNames[indexPath.section]
    if let postsArray = threads[sectionName] {
        return postsArray[indexPath.row]
    }
    return nil
}

/// Adds the given post to the thread associated with it
/// (the thread is set as an instance variable of the post)
///
/// - Parameter post: The post to be added to the model
func addPostToThread(post: Post) {
    threads[post.thread]?.append(post)
}

func clearThreads() {
    threads = [SnapCloneConstants.memes: [], SnapCloneConstants.dog: [], SnapCloneConstants.random: []]
}

/*
 Store the data for a new post in the Firebase database.
 Make sure you understand the hierarchy of the Posts tree before attempting to write any data to Firebase!
 Each post node contains the following properties:
 
 - (string) imagePath: corresponds to the location of the image in the storage module. This is already defined for you below.
 - (string) thread: corresponds to which feed the image is to be posted to.
 - (string) username: corresponds to the display name of the current user who posted the image.
 - (string) date: the exact time at which the image is captured as a string
 Note: Firebase doesn't allow us to store Date objects, so we have to represent the date as a string instead. You can do this by creating a DateFormatter object, setting its dateFormat (check Constants.swift for the correct date format!) and then calling dateFormatter.string(from: Date()).
 
 Create a dictionary with these four properties and store it as a new child under the Posts node (you'll need to create a child using an auto ID)
 
 Finally, save the actual data to the storage module by calling the store function below.ß
 */
func addPost(postImage: UIImage, thread: String, username: String) {
    let dbRef = Database.database().reference()
    let data = UIImageJPEGRepresentation(postImage, 1.0)
    let path = "Images/\(UUID().uuidString)"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = SnapCloneConstants.dateFormat
    let dateString = dateFormatter.string(from: Date())
    let postDict: [String:AnyObject] = [SnapCloneConstants.firImagePathNode: path as AnyObject,
                                        SnapCloneConstants.firUsernameNode: username as AnyObject,
                                        SnapCloneConstants.firThreadNode: thread as AnyObject,
                                        SnapCloneConstants.firDateNode: dateString as AnyObject]
    dbRef.child(SnapCloneConstants.firPostsNode).childByAutoId().setValue(postDict)
    store(data: data, toPath: path)
}

// This is the function that actually sends
// your data to Firebase's Storage to store it using the given 'path' as it's
// reference.
//
func store(data: Data?, toPath path: String) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).putData(data!, metadata: nil) { (metadata, error) in
        if let error = error {
            print(error)
        }
    }
}

/*
 This function should query Firebase for all posts and return an array of Post objects.
 You should use the function 'observeSingleEvent' (with the 'of' parameter set to .value) to get a snapshot of all of the nodes under "Posts".
 If the snapshot exists, store its value as a dictionary of type [String:AnyObject], where the string key corresponds to the ID of each post.
 
 Then, make a query for the user's read posts ID's. In the completion handler, complete the following:
 - Iterate through each of the keys in the dictionary
 - For each key:
 - Create a new Post object, where Posts take in a key, username, imagepath, thread, date string, and read property. For the read property, you should set it to true if the key is contained in the user's read posts ID's and false otherwise.
 - Append the new post object to the post array.
 - Finally, call completion(postArray) to return all of the posts.
 - If any part of the function fails at any point (e.g. snapshot does not exist or snapshot.value is nil), call completion(nil).
 
 Remember to use constants defined in Strings.swift to refer to the correct path!
 */
func getPosts(user: CurrentUser, completion: @escaping ([Post]?) -> Void) {
    let dbRef = Database.database().reference()
    var postArray: [Post] = []
    dbRef.child(SnapCloneConstants.firPostsNode).observeSingleEvent(of: .value, with: { snapshot -> Void in
        if snapshot.exists() {
            if let posts = snapshot.value as? [String:AnyObject] {
                user.getReadPostIDs(completion: { (ids) in
                    for postKey in posts.keys {
                        if let currentPost = posts[postKey] {
                            var readStatus = false
                            if ids.contains(postKey) {
                                readStatus = true
                            }
                            let postObj = Post(id: postKey, username: currentPost[SnapCloneConstants.firUsernameNode] as! String, postImagePath: currentPost[SnapCloneConstants.firImagePathNode] as! String, thread: currentPost[SnapCloneConstants.firThreadNode] as! String, dateString: currentPost[SnapCloneConstants.firDateNode] as! String, read: readStatus)
                            postArray.append(postObj)
                        } else {
                            print(SnapCloneConstants.invalidPostkey)
                        }
                    }
                    completion(postArray)
                })
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    })
}


func getDataFromPath(path: String, completion: @escaping (Data?) -> Void) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).getData(maxSize: Int64(SnapCloneConstants.imageSize)) { (data, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
            completion(data)
        } else {
            completion(nil)
        }
    }
}

