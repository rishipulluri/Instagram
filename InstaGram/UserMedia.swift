//
//  UserMedia.swift
//  InstaGram
//
//  Created by saritha on 2/25/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
import Parse


class UserMedia: NSObject {
    var commento: String
    init(comment:String)
    {
        commento = comment;
        
    }
    
    func Postpost(withCompletion completion: PFBooleanResultBlock?)
    {
        let media = PFObject(className: "UserMedia")
        media.setObject(commento, forKey: "caption")
        media.setObject(PFUser.currentUser()!, forKey: "Author")
        media.saveInBackgroundWithBlock(completion)

        
        
    }
    
  
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        
        let media = PFObject(className: "UserMedia")

        // Add relevant fields to the object
        media["media"] = getPFFileFromImage(image) // PFFile column type
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
  
    
    /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    

}
